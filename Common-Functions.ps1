function Enable-Transscript([string]$LogsPath = ".\Logs")
{
    if (-not (Test-Path $LogsPath)) {
        Write-Message -Message "Creating $LogsPath"
        New-Item -ItemType Directory -Path $LogsPath -Force
    }
    $timestamp = (Get-Date).ToString("yyyy-MM-dd_hhmmss")
    Start-Transcript -Path "$LogsPath\$($timestamp)_run.log"
}

function Write-Message([string] $Message) {
    $timestamp = (Get-Date).ToString("yyyy-MM-dd_hhmmss")
    Write-Host "$timestamp`: $Message" -Verbose
}
#Value for Scope can be "User, Machine, All" where User = User + Process; Machine = Machine + Process; All = all 3 scopes are applied.
function Set-EnvironmentVariable([string] $VarName, [string] $VarValue, [ValidateSet("All", "User", "Machine")][String]$Scope = "All") {
    Write-Message -Message "Add environment variable '$VarName'"
    
    # Always change in process scope
    [System.Environment]::SetEnvironmentVariable($VarName, $VarValue, [System.EnvironmentVariableTarget]::Process)
    if ($Scope -eq "All" -or $Scope -eq "Machine") {
        [System.Environment]::SetEnvironmentVariable($VarName, $VarValue, [System.EnvironmentVariableTarget]::Machine)
    }
    if ($Scope -eq "All" -or $Scope -eq "User") {
        [System.Environment]::SetEnvironmentVariable($VarName, $VarValue, [System.EnvironmentVariableTarget]::User)    
    }
}

function Remove-EnvironmentVariable([string] $VarName, [String]$Scope = "All") {
    Write-Message -Message "Remove environment variable '$VarName'"
    $VarValue = $null
    Set-EnvironmentVariable -VarName $VarName -VarValue $VarValue -Scope $Scope
}

function Refresh-EnvironmentPath()
{
    $env:Path = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
}
function Remove-EnvironmentPath([string] $VarValue, [ValidateSet("All", "User", "Machine")][String]$Scope = "All") {
    Write-Message -Message "Remove environment path '$VarValue'"

    $pathQueryScope = [System.EnvironmentVariableTarget]::User
    if ($Scope -eq "All" -or $Scope -eq "Machine") {
        $pathQueryScope = [System.EnvironmentVariableTarget]::Machine
    }

    $currentSystemPath = [System.Environment]::GetEnvironmentVariable("PATH", $pathQueryScope)
    $allCurrentPaths = $currentSystemPath.Split(";", [System.StringSplitOptions]::RemoveEmptyEntries)
    $newPath = [string]::Empty
    $allCurrentPaths | ForEach-Object {
        $item = $_.Trim().ToLower()
        if ($item -ne $VarValue.Trim().ToLower()) {
            $newPath += "$($_.Trim());"
        }
    }
    Set-EnvironmentVariable -VarName "PATH" -VarValue $newPath -Scope $Scope
}

function Set-EnvironmentPath([string] $VarValue, [ValidateSet("All", "User", "Machine")][String]$Scope = "All") {
    Write-Message -Message "Add environment path '$VarValue'"

    $pathQueryScope = [System.EnvironmentVariableTarget]::User
    if ($Scope -eq "All" -or $Scope -eq "Machine") {
        $pathQueryScope = [System.EnvironmentVariableTarget]::Machine
    }

    $currentSystemPath = [System.Environment]::GetEnvironmentVariable("PATH", $pathQueryScope)
    $allCurrentPaths = $currentSystemPath.Split(";", [System.StringSplitOptions]::RemoveEmptyEntries)
    $contains = $False
    $allCurrentPaths | ForEach-Object {
        $item = $_.Trim().ToLower()
        if ($item -eq $VarValue.Trim().ToLower()) {
            $contains = $True
            return
        }
    }

    if (-not $contains) {
        $newPath = [string]::Empty
        $allCurrentPaths | ForEach-Object {
            $newPath += "$($_.Trim());"
        }
        $newPath += "$($VarValue.Trim());"
        
        Set-EnvironmentVariable -VarName "PATH" -VarValue $newPath -Scope $Scope
    }
}

