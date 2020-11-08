[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

# Installing PS5 modules
$installScriptPath = "$PSScriptRoot\Temp_Install_Modules5.ps1"
$installScriptContent = "`$env:PSModulePath=`"C:\Users\$env:USERNAME\Documents\WindowsPowerShell\Modules;C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules`";"

$Config.Ps5InstallModuleCommands | ForEach-Object {
  $installScriptContent += "$_;"
}

Write-Host "Script Content for PS7: $installScriptContent"

Set-Content -Path "$installScriptPath" -Value $installScriptContent
Write-Message -Message "Checking and installing PS Modules for Powershell v5.*"
powershell.exe -File $installScriptPath
