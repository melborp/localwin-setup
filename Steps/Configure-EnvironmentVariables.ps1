[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

Write-Message -Message "Removing environment path"
$Config.EnvironmentPathRemove | ForEach-Object {
    Remove-EnvironmentPath -ExistingValue "$_"
}

Write-Message -Message "Adding environment path"
$Config.EnvironmentPathAdd | ForEach-Object {
    Set-EnvironmentPath -NewValue "$_"
}

Write-Message -Message "Removing environment vars"
$Config.EnvironmentVarsRemove | ForEach-Object {
    Remove-EnvironmentVariable @_
}

Write-Message -Message "Adding environment vars"
$Config.EnvironmentVarsAdd | ForEach-Object {
    Set-EnvironmentVariable @_
}