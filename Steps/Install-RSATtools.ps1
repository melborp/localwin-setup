[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

$ExecPolicy = Set-ExecutionPolicy Bypass -Scope Process -Force
$RSAT_tools_state = (Get-WindowsCapability -Online | Where-Object { $_.Name.Contains("Rsat.") }).State
$RSAT_tools_install = Get-WindowsCapability -Online | Where-Object { $_.Name.Contains("Rsat.") } | Add-WindowsCapability -Online

if ($RSAT_tools_state -eq "Installed") {
   Write-Message -Message "RSAT tools are already installed. Skipping"
} else {
   Write-Message -Message "Installing RSAT tools."
   Start-Process PowerShell.exe -ArgumentList "-NoProfile", "-command $ExecPolicy; $RSAT_tools_install" -Wait
   
   Start-Sleep -Seconds 10

   $RSAT_tools_status = Get-WindowsCapability -Online | Where-Object { $_.Name.Contains("Rsat.") } | Format-Table
   Write-Message -Message ([array]$RSAT_tools_status | Out-String)
} 