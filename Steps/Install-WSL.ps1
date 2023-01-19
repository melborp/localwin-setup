[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

$ExecPolicy = Set-ExecutionPolicy Bypass -Scope Process -Force
$SoftwarePath = $Config.SoftwarePath
$PSScriptRootLogs = "$PSScriptRoot\..\Logs"


$WindowsFeatures = @('HypervisorPlatform', 'VirtualMachinePlatform', 'Microsoft-Windows-Subsystem-Linux')

$WSLupdateURI = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$WSLupdateLocation = Join-Path $SoftwarePath wsl_update_x64.msi
$WSLinstall_log = Join-Path $PSScriptRootLogs wsl_update_x64-install.log

$DistroPackageLocation = Join-Path $SoftwarePath Debian.appx
$DistroPackageURI = $Config.WSLDistroPackageURI

$WindowsFeatures | ForEach-Object {
    $WinFeatureState = (Get-WindowsOptionalFeature -FeatureName $_ -Online).State 
    
    if ($WinFeatureState -eq "Enabled") {
        Write-Message "$_ is already enabled"
    } else {
        Write-Message "Enabling $_"
        Enable-WindowsOptionalFeature -Online -FeatureName $_ -NoRestart
    }
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
    if ($DistroPackageURI -ne "") {
      Write-Message "Installing Debian Distro for WSL"
      Invoke-WebRequest -Uri $DistroPackageURI -OutFile $DistroPackageLocation -UseBasicParsing -Verbose
      Add-AppxPackage $DistroPackageLocation -Verbose
    }
}
