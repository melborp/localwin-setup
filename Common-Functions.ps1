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
function Set-EnvironmentVariable([string] $VarName, [string] $VarValue) {
    Write-Message -Message "Add environment variable '$VarName'"
    [System.Environment]::SetEnvironmentVariable($VarName, $VarValue, [System.EnvironmentVariableTarget]::Machine)
    [System.Environment]::SetEnvironmentVariable($VarName, $VarValue, [System.EnvironmentVariableTarget]::Process)
    [System.Environment]::SetEnvironmentVariable($VarName, $VarValue, [System.EnvironmentVariableTarget]::User)
}

function Remove-EnvironmentVariable([string] $VarName) {
    Write-Message -Message "Remove environment variable '$VarName'"
    $VarValue = $null
    [System.Environment]::SetEnvironmentVariable($VarName, $VarValue, [System.EnvironmentVariableTarget]::Machine)
    [System.Environment]::SetEnvironmentVariable($VarName, $VarValue, [System.EnvironmentVariableTarget]::Process)
    [System.Environment]::SetEnvironmentVariable($VarName, $VarValue, [System.EnvironmentVariableTarget]::User)
}

function Refresh-EnvironmentPath()
{
    $env:Path = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
}
function Remove-EnvironmentPath([string]$ExistingValue) {
    Write-Message -Message "Remove environment path '$ExistingValue'"
    $currentSystemPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
    $allCurrentPaths = $currentSystemPath.Split(";", [System.StringSplitOptions]::RemoveEmptyEntries)
    $newPath = [string]::Empty
    $allCurrentPaths | ForEach-Object {
        $item = $_.Trim().ToLower()
        if ($item -ne $ExistingValue.Trim().ToLower()) {
            $newPath += "$($_.Trim());"
        }
    }
    Set-EnvironmentVariable -VarName "PATH" -VarValue $newPath
}

function Set-EnvironmentPath([string]$NewValue) {
    Write-Message -Message "Add environment path '$NewValue'"
    $currentSystemPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
    $allCurrentPaths = $currentSystemPath.Split(";", [System.StringSplitOptions]::RemoveEmptyEntries)
    $contains = $False
    $allCurrentPaths | ForEach-Object {
        $item = $_.Trim().ToLower()
        if ($item -eq $NewValue.Trim().ToLower()) {
            $contains = $True
            return
        }
    }

    if (-not $contains) {
        $newPath = [string]::Empty
        $allCurrentPaths | ForEach-Object {
            $newPath += "$($_.Trim());"
        }
        $newPath += "$($NewValue.Trim());"
        
        Set-EnvironmentVariable -VarName "PATH" -VarValue $newPath
    }
}

