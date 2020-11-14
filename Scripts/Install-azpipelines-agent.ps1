
[CmdletBinding()]
Param(
  [Parameter(Mandatory=$true)]   [string] $Url,
  [Parameter(Mandatory=$true)]   [string] $Token,
  [Parameter(Mandatory=$true)]   [string] $AgentName,
  [Parameter(Mandatory=$true)]   [string] $PoolName,
  [Parameter(Mandatory=$true)]   [string] $Path,
  [Parameter(Mandatory=$true)]   [pscredential] $ServiceAccount
)

Push-Location $Path -Verbose

.\config.cmd --unattended --url $Url --auth pat --token $Token --pool $PoolName --agent $AgentName --runAsService --windowsLogonAccount $ServiceAccount.UserName --windowsLogonPassword ($ServiceAccount.GetNetworkCredential().Password) --noRestart

Pop-Location