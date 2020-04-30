[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

$LocalReposFolder = $Config.LocalReposFolder
$ToolsPath = $Config.ToolsPath
$psProfileFilename = $Config.PSProfileFilename

$psProfile = Get-Content "$PSScriptRoot\..\Static\$psProfileFilename" -Verbose
$psProfile = $psProfile.Replace("__LocalReposFolder__", $LocalReposFolder).Replace("__ToolsPath__", $ToolsPath)
Set-Content -Encoding utf8 -Path "C:\Users\$env:USERNAME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Value $psProfile -Verbose
if (-not (Test-Path "C:\Users\$env:USERNAME\Documents\PowerShell")) {
    New-Item -ItemType Directory -Path "C:\Users\$env:USERNAME\Documents\PowerShell" -Verbose
}
Set-Content -Encoding utf8 -Path "C:\Users\$env:USERNAME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Value $psProfile -Verbose    

# Configure git
git config --global user.name "$($Config.Git.Username)"
git config --global user.email "$($Config.Git.Email)"
git config --global remote.origin.prune $($Config.Git.Prune)