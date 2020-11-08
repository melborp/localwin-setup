[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

# Installing PS7 modules
$installScriptPath = "$PSScriptRoot\Temp_Install_Modules7.ps1"
$installScriptContent = "`$env:PSModulePath=`"C:\Users\$env:USERNAME\Documents\PowerShell\Modules;C:\Program Files\PowerShell\Modules;c:\program files\powershell\7\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules`";"

$Config.Ps7InstallModuleCommands | ForEach-Object {
  $installScriptContent += "$_;"
}

Write-Host "Script Content for PS7: $installScriptContent"

Set-Content -Path "$installScriptPath" -Value $installScriptContent
Write-Message -Message "Checking and installing PS Modules for Powershell Core 7.*"
pwsh.exe -File $installScriptPath