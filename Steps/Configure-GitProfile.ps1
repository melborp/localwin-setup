[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"

# Configure git
git config --global user.name "$($Config.Git.Username)"
git config --global user.email "$($Config.Git.Email)"
git config --global remote.origin.prune $($Config.Git.Prune)