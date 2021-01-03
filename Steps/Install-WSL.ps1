[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

$ExecPolicy = Set-ExecutionPolicy Bypass -Scope Process -Force
$SoftwarePath = $Config.SoftwarePath

$WSLstate = (Get-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online).State 
$WSLinstall = Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

$WSLupdateURI = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$WSLupdateLocation = Join-Path $SoftwarePath wsl_update_x64.msi
$WSLinstall_log = Join-Path $LogsPath wsl_update_x64-install.log

$DistroPackageLocation = Join-Path $SoftwarePath Debian.appx
$DistroPackageURI = "https://aka.ms/wsl-debian-gnulinux"

if ($WSLstate -eq "Enabled") {
    Write-Message "Windows-Subsystem-for-Linux is already enabled"
} else {
    Write-Message "Enabling Windows-Subsystem-for-Linux"
    Start-Process PowerShell.exe -ArgumentList "-NoProfile", "-command $ExecPolicy; $WSLinstall" -Wait
}

if (Test-Path $WSLinstall_log -Type Leaf) {
    Write-Message "WSL2 Update already installed. Skipping"
} else {
    Write-Verbose "Installing WSL2 Update"
    Invoke-WebRequest -Uri $WSLupdateURI -OutFile $WSLupdateLocation -UseBasicParsing -Verbose
    MsiExec.exe /i $WSLupdateLocation /qn /L*v $WSLinstall_log
}

if (Test-Path $DistroPackageLocation -Type Leaf) {
    Write-Message "Debian Distro for WSL already installed. Skipping"
} else {
    Write-Message "Installing Debian Distro for WSL"
    Invoke-WebRequest -Uri $DistroPackageURI -OutFile $DistroPackageLocation -UseBasicParsing -Verbose
    Add-AppxPackage $DistroPackageLocation -Verbose
}
