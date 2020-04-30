[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

$chocoInstalled = $True
try {
    $chocoVersion = choco --version
    Write-Message "Choco $chocoVersion installed. Skipping."    
} catch {
    $chocoInstalled = $False
}
if (-not $chocoInstalled) {
    Write-Message "Installing Choco."
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    # Install Choco
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}