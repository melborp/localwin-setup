[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

# Creating Shortcuts
$Config.Shortcuts | Foreach-Object {
    if (Test-Path $($_.scName + ".lnk") -Type Leaf ) {
        Write-Message -Message "Shortcut for '$($_.scName)' exsists"
    } else {
        Write-Message -Message "Creating a shortcut for '$($_.scName)'"
        $TargetFile
        $WScriptShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WScriptShell.CreateShortcut($($_.scName + ".lnk"))
        $Shortcut.TargetPath = $($_.Target)
        $Shortcut.Save()
    }
}
