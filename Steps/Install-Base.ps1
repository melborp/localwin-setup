[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -Verbose
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Verbose -Confirm $False

# Enable WSL2 in v2004 of Windows,  this will want to reboot and then offer another update and reboot
#Enable-WindowsOptionalFeature -Online -FeatureName $("VirtualMachinePlatform", "Microsoft-Windows-Subsystem-Linux")
# https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel
# download https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi