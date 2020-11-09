[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

Write-Message -Message "Installing PIP Packages"
$Config.PipInstallCommands | Foreach-Object {
    Write-Host "Running command '$($_.Exec)' and '$($_.Args)'"
    
    &"$($_.Exec)" $_.Args    
}