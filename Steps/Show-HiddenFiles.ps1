[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

function Show-HiddenFiles {
    $RegKey_Property_Name = 'Hidden'
    $RegKey = Get-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    $Key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'

    if ($RegKey.GetValue($RegKey_Property_Name) -eq 1 ) {
        Write-Warning "Show Hidden Files Value Already Set"
    } else {
        Set-ItemProperty $Key Hidden 1
        Write-Verbose "Show Hidden Files Value Set"
    }

    Start-Sleep 3
}
function Show-FileExtensions {
    $RegKey_Property_Name = 'HideFileExt'
    $RegKey = Get-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    $Key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'

    if ($RegKey.GetValue($RegKey_Property_Name) -eq 0 ) {
        Write-Warning "Show File Extensions Already Set"
    } else {
        Set-ItemProperty $Key HideFileExt 0
        Write-Verbose "Show File Extensions Already Set"
    }

    Start-Sleep 3
}
function Show-SuperHiddenFiles {
    $RegKey_Property_Name = 'ShowSuperHidden'
    $RegKey = Get-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    $Key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'

    if ($RegKey.GetValue($RegKey_Property_Name) -eq 1 ) {
        Write-Warning "Show Super Hidden Files Value Already Set"
    } else {
        Set-ItemProperty $Key ShowSuperHidden 1
        Write-Verbose "Show Super Hidden Files Value Set"
    }

    Start-Sleep 3
}

Show-HiddenFiles
Show-FileExtensions
Show-SuperHiddenFiles