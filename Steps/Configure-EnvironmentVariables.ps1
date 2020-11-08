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

#Value for Scope can be "User, Machine, All" where User = User + Process; Machine = Machine + Process; All = all 3 scopes are applied.
Write-Message -Message "Removing environment vars"
$Config.EnvironmentVarsRemove | ForEach-Object {
    Remove-EnvironmentVariable @_
}

Write-Message -Message "Adding environment vars"
$Config.EnvironmentVarsAdd | ForEach-Object {
    Set-EnvironmentVariable @_
}