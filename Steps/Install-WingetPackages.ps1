[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

Write-Message -Message "Installing Winget Packages"
$Config.WingetPackages | Foreach-Object {
    "Checking Winget Package with Id: $($_.Id)"
    if ($_.Version) {
        winget install --id $($_.Id) --version $($_.Version) --silent --accept-package-agreements
    } else {
        $items = winget list $($_.Id) | select-string $($_.Id) -List
        if ($items.Length -gt 0) {
            winget upgrade --id $($_.Id) --silent
        } else {
            winget install --id $($_.Id) --silent --accept-package-agreements
        }
    }
}