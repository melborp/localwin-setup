[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

Write-Message -Message "Installing PIP Packages"
$Config.PipPackages | Foreach-Object {
    & $_
}