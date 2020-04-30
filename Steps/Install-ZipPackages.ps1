[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"
$ErrorActionPreference = "Stop"
$SoftwarePath = $Config.SoftwarePath
$ToolsPath = $Config.ToolsPath

Write-Message -Message "Installing zip packages to '$SoftwarePath'"
$Config.ZipInstallSoftware | ForEach-Object {
    if (-not (Test-Path "$SoftwarePath\$($_.FolderName)")) {
        Write-Message -Message "Downloading and configuring $($_.Url)"
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri "$($_.Url)" -OutFile ".\$($_.FolderName).zip" -Verbose
        Expand-Archive -Path ".\$($_.FolderName).zip" -DestinationPath "$SoftwarePath\$($_.FolderName)" -Force -Verbose
    }
}
Write-Message -Message "Installing zip packages to '$ToolsPath'"
$Config.ZipInstallTools | ForEach-Object {
    if (-not (Test-Path "$ToolsPath\$($_.FolderName)")) {
        Write-Message -Message "Downloading and configuring $($_.Url)"
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri "$($_.Url)" -OutFile ".\$($_.FolderName).zip" -Verbose
        Expand-Archive -Path ".\$($_.FolderName).zip" -DestinationPath "$ToolsPath\$($_.FolderName)" -Force -Verbose
    }
}
