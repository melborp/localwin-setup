[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

#Switch         Function
# No switches 	Disables unnecessary services and scheduled tasks. Removes all UWP apps except for some useful ones. Disables Cortana, OneDrive, restricts default privacy settings and cleans up the default start menu.
#-AppAccess		By default this script will restrict almost all the permissions in Settings -> Privacy. This will prevent that from happening.
#-ClearStart    Empties the start menu completely leaving you with just the apps list.
#-OneDrive		Leaves OneDrive and Onedrive for Business fully functional.
#-Tablet		Use this for tablets or 2-in-1s to leave location and sensors enabled.
#-AppsOnly      Only removes apps, doesn't touch privacy settings, services, and scheduled tasks. Cannot be used with -SettingsOnly switch. Can be used with all the others.

# In Use -AppsOnly -Tablet -OneDrive -ClearStart -AppAccess

$ExecPolicy = Set-ExecutionPolicy Bypass -Scope Process -Force
$PSScriptRootScripts = Join-Path $PSScriptRoot "Scripts"

$DecrapTestFile = Join-Path $LogsPath run_decrapifier_completed
$DecrapScript = Join-Path $PSScriptRootScripts decrapifier.ps1

If (Test-Path $DecrapTestFile -Type Leaf) {
    Write-Message "Decrapifier has already been run"
} Else {
    Write-Message "Running Decrapifier"
    New-Item -ItemType file $DecrapTestFile -Verbose
    Start-Process PowerShell.exe -ArgumentList "-NoProfile", "-command $ExecPolicy; $DecrapScript -AppsOnly -Tablet -OneDrive -ClearStart -AppAccess" -Wait

}
