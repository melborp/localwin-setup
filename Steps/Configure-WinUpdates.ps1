[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

# Script Changes Windows Updates to Manual
# Adds Registry settings that allows you to download and install windows updates when convenient
#
# Registry Value Types
# 2 - "Notify for download and notify for install." 
# 3 - "Auto download and notify for install." 
# 4 - "Auto download and schedule the install." 
# 5 - "Allow local admin to choose settings." 
#

# Change location to registry
try {
    Set-Location HKLM:

    #Reg item location
    $REGPath = ".\SOFTWARE\Policies\Microsoft\Windows\"
    $ItemName1 = "WindowsUpdate"
    $ItemName2 = "AU"
    $DWORDName = "AUOptions"
    $DWRODValue = "2"

    # Check if Registry Item WindowsUpdate exists, if not create it

    $ChkWindowsUpdateExists = Test-Path $("$REGPath"+"$ItemName1")
    if ($ChkWindowsUpdateExists -eq $True) {
        Write-Message -Message "Registry Item $ItemName1 exists"
    } else {
        Write-Message -Message "Creating registry itrem $ItemName1"
        New-Item -ItemType "Key" -Name $ItemName1 -Path $REGPath -ErrorAction SilentlyContinue -Verbose
    }

    # Check if Registry Item AU exists, if not create it

    $ChkAUExists = Test-Path $("$REGPath"+"$ItemName1"+"\"+"$ItemName2")
    if ($ChkAUExists -eq $True) {
        Write-Message -Message "Registry Item $ItemName2 exists"
    } else {
        Write-Message -Message "Creating registry itrem $ItemName2"
        New-Item -ItemType "Key" -Name $ItemName2 -Path $("$REGPath"+"$ItemName1"+"\") -Verbose
    }

    # Check if DWORD Property exists, if not create it

    $DWORDExists = Get-ItemProperty -Name $DWORDName -Path $("$REGPath"+"$ItemName1"+"\"+"$ItemName2") -ErrorAction SilentlyContinue
    if ($null -eq $DWORDExists) {
        Write-Message -Message "DWORD Property $DWORDName does not exist. Creating"
        New-ItemProperty -PropertyType "DWORD" -Name $DWORDName -Path $("$REGPath"+"$ItemName1"+"\"+"$ItemName2") -Value $DWRODValue -ErrorAction SilentlyContinue -Verbose
    } else {
        $AUOPtionsValue = (Get-ItemProperty -Path ".\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU\" -Name $DWORDName).$DWORDName
        Write-Message -Message "DWORD Property $DWORDName exists, with value: $AUOPtionsValue"
    }  
}
finally {
    Set-Location C:
}