[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

Write-Message -Message "Installing Choco Packages"
$Config.ChocoPackages | Foreach-Object {
    if ($_.Version) {
        choco install $($_.Name) --no-progress --version=$($_.Version) -y $_.Args
    } else {
        $items = choco search -l $($_.Name) | select-string $($_.Name) -List
        if ($items.Length -gt 1) {
            choco upgrade $($_.Name) --no-progress -y $_.Args
        } else {
            choco install $($_.Name) --no-progress -y $_.Args
        }
    }
}