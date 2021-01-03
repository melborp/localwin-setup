[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

# Creating Shortcuts
$Config.Shortcuts | Foreach-Object {
    if (Test-Path ($_.Target) -Type Leaf ) {
        Write-Message -Message "Shortcut for "$($_.Name)" exsists"
    } else {
        Write-Message -Message "Creating a shortcut for "$($_.Name)""
        Add-Shortcut $($_.Name) $($_.Target)
    }
}