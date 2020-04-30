[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

# TODO: make the modules configurable
$installModules = "Install-Module -Name Az -AllowClobber -Scope AllUsers -Verbose -Force; Install-Module -Name PSScriptAnalyzer;"

Write-Message "Modules to be installed are: '$installModules'"

# Using this approach due to not knowing if its run from powershell or pwsh
$installScriptPath = "$PSScriptRoot\Temp_Install_Modules5.ps1"
Set-Content -Path "$installScriptPath" -Value "`$env:PSModulePath=`"C:\Users\$env:USERNAME\Documents\WindowsPowerShell\Modules;C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules`"; $installModules"

Write-Message -Message "Checking and installing PS Modules for Powershell v5.*"
powershell.exe -File $installScriptPath

$installScriptPath = "$PSScriptRoot\Temp_Install_Modules7.ps1"
Set-Content -Path "$installScriptPath" -Value "`$env:PSModulePath=`"C:\Users\$env:USERNAME\Documents\PowerShell\Modules;C:\Program Files\PowerShell\Modules;c:\program files\powershell\7\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules`"; $installModules"
Write-Message -Message "Checking and installing PS Modules for Powershell Core 7.*"
pwsh.exe -File $installScriptPath