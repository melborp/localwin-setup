
    if ((Get-ExecutionPolicy) -ne 'Bypass') {
      Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force -Verbose
    }
    
    Set-Location __LocalReposFolder__ -Verbose

    Import-Module '__ToolsPath__\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psm1'

    __ToolsPath__\ColorTool\ColorTool.exe -q __ToolsPath__\ColorTool\schemes\OneHalfDark.itermcolors

# Screen Background RGB 39 44 51