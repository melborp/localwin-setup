
    if ((Get-ExecutionPolicy) -ne 'Bypass') {
      Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force -Verbose
    }
 
    Import-Module posh-git
    Import-Module oh-my-posh
    Set-Theme Paradox

    #Set-Location __LocalReposFolder__ -Verbose

    # look to replace poshgit with powerline
    # https://github.com/Jaykul/PowerLine
#    Import-Module '__ToolsPath__\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psm1'

    #__ToolsPath__\ColorTool\ColorTool.exe -q __ToolsPath__\ColorTool\schemes\OneHalfDark.itermcolors

# Screen Background RGB 39 44 51