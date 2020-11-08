# RunSteps is a way to override what to install, run only specific steps
[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [string]$ConfigFilePath = '.\Config.ps1',
  [Parameter(Mandatory=$False)]   [string[]]$RunSteps=@()
)

try {

    $ErrorActionPreference = "Stop"

    . "$PSScriptRoot\Common-Functions.ps1"

    Enable-Transscript

    $Config = & $ConfigFilePath

    $Config.DefaultRunSteps | ForEach-Object { 
      $step = $_ #file name
      if ($RunSteps.Length -gt 0 -and (-not $RunSteps.Contains($step))) {
        Write-Message "Skipping step '$step'. It is not part of the RunSteps specified."
        return # skip
      }

      $filename = $step
      try {
        Refresh-EnvironmentPath
        $scriptFile = ".\Steps\$filename.ps1"
        Write-Message "---------------------------"
        Write-Message -Message "Start Running $scriptFile"
        Write-Message "---------------------------"
        & $scriptFile -Config $Config
        Refresh-EnvironmentPath
        Write-Message "---------------------------"
        Write-Message -Message "Finish Running $scriptFile"
        Write-Message "---------------------------"
      } catch {
        Write-Message -Message "WARNING: Executing steps\$filename.ps1 caught an error. $($_.Message)"
      }
    }
}
finally {
    Stop-Transcript
}