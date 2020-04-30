[CmdletBinding()]
Param(
  [Parameter(Mandatory=$False)]   [hashtable]$Config
)

. "$PSScriptRoot\..\Common-Functions.ps1"
$ErrorActionPreference = "Continue"

Write-Message -Message "Installing npm global tools"
$Config.NpmGlobalTools | ForEach-Object {
    npm install -g $_ *>&1 | ForEach-Object {
        $obj = $_
        if ( $obj -is [System.Management.Automation.ErrorRecord] ) {
            $s = $obj.Exception.Message
        }
        else {
            $s = $obj.ToString()
        }
        if ( $s.Contains('ERR!') ) {
            Write-Error $s
        }
        else {
            Write-Output $s
        }
    }
    $LASTEXITCODE = 0        
}