[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

$Config.CommonFiles | Foreach-Object {
    if (Test-Path ($_.Destination) -Type Container) {
        Write-Message -Message "Common Files exsist"
    } else {
        Write-Message -Message "Copying Common Files"
        Copy-Item -Path $($_.Path) -Filter *.* -Destination $($_.Destination) -Recurse
    }
}