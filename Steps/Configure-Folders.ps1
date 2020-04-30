[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

$Config.LocalPaths | ForEach-Object {
    if ((Test-Path "$_") -eq $false) {
        New-Item -Path $_ -Force -ItemType Directory -Verbose
    }    
}