[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

#
# Setup vs code extensions
#

Write-Message -Message "Installing vs code extensions"
$Config.VsCodeExtensions | ForEach-Object {
    code --install-extension $_
}