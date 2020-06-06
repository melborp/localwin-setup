$Config = @{
    LocalPaths = @('c:\repos','c:\cache\npm','c:\cache\nuget','c:\cache\software','c:\tools', 'C:\Software');
    CacheRootLocation = 'c:\cache';
    SoftwarePath = 'C:\Software';
    ToolsPath = 'C:\tools';
    LocalReposFolder = "C:\repos";
    PSProfileFilename = "Microsoft.PowerShell_profile.ps1";
    Git = @{ Username = "Taavi Koosaar"; Email = "taavi@someemail.com"; Prune = "true";}
    ChocoPackages = @(
        @{ Name = "powershell-core" };
        @{ Name = "7zip" };
        @{ Name = "vscode" };
        @{ Name = "git" };
        @{ Name = "poshgit" };
        @{ Name = "googlechrome" };
        @{ Name = "microsoft-teams"; };
        @{ Name = "microsoft-edge"; };
        @{ Name = "slack"; };
        @{ Name = "foxitreader"; };
        @{ Name = "docker-desktop" };
        @{ Name = "vlc" };
        @{ Name = "azure-data-studio"; };
        @{ Name = "sql-server-management-studio"; };
        @{ Name = "nodejs-lts"; };
        @{ Name = "dotnetcore-sdk"; Version = "2.2.402"; Args = "--side-by-side" };
        @{ Name = "dotnetcore-sdk"; Version = "3.0.103"; Args = "--side-by-side" };
        @{ Name = "dotnetcore-sdk"; Version = "3.1.102"; Args = "--side-by-side" };
        @{ Name = "dotnetcore-sdk"; Version = "3.1.201"; Args = "--side-by-side" };        
        @{ Name = "curl" };
        @{ Name = "Nuget.CommandLine"; Version = "5.5.1"; };
        @{ Name = "openjdk11"; };
        @{ Name = "jmeter"; Version = "5.2.1"; Args="--ignore-dependencies";};
        @{ Name = "maven"; };
        @{ Name = "kubernetes-cli"; };
        @{ Name = "kubernetes-helm"; };
        @{ Name = "azure-cli"; };
        @{ Name = "azcopy10"; };
        @{ Name = "azure-functions-core-tools"; };
        @{ Name = "keepass";Version = "2.44"; };
        @{ Name = "servicebusexplorer"; };
        @{ Name = "microsoftazurestorageexplorer"; };
        @{ Name = "visualstudio2019professional"; };
        @{ Name = "visualstudio2019-workload-azure"; };
        @{ Name = "visualstudio2019-workload-manageddesktop"; };
        @{ Name = "visualstudio2019-workload-netcoretools"; };
        @{ Name = "visualstudio2019-workload-netweb"; };
        @{ Name = "visualstudio2019-workload-node"; };
        @{ Name = "visualstudio2019-workload-data"; };
        @{ Name = "microsoft-windows-terminal"; };
        
    );
    NpmGlobalTools = @(
        "npm",
        "gulp-cli@2.2.0",
        "grunt-cli@1.3.2",
        "node-sass",
        "typescript",
        "tslint",
        "tfx-cli"
    );
    VsCodeExtensions = @(
        "ms-vscode.csharp",
        "ms-dotnettools.csharp",
        "ms-vscode.PowerShell",
        "vscode-icons-team.vscode-icons",
        "eamodio.gitlens",
        "ms-azuretools.vscode-docker",
        "msazurermtools.azurerm-vscode-tools",
        "bencoleman.armview",
        "ms-azure-devops.azure-pipelines",
        "dotjoshjohnson.xml",
        "humao.rest-client",
        "ms-kubernetes-tools.vscode-kubernetes-tools",
        "streetsidesoftware.code-spell-checker",
        "MS-vsliveshare.vsliveshare",
        "msjsdiag.debugger-for-chrome",
        "ms-vscode-remote.remote-wsl"
    );
    #PsModules = @(@{ Name = "";});
    ZipInstallSoftware = @(
        #@{ Url = "";}
    );
    ZipInstallTools =  @(
        # Colorscheme "One Half Dark" is builtin to windows terminal, no color tool needed.
        #@{ Url = "https://github.com/microsoft/terminal/releases/download/1904.29002/ColorTool.zip"; FolderName = "ColorTool"; }
    );
    EnvironmentPathAdd = @(
        "C:\Python27amd64"
    );
    EnvironmentPathRemove = @(
    );
    EnvironmentVarsAdd = @(
        @{ VarName = "NPM_CONFIG_PREFIX"; VarValue = "c:\cache\npm\prefix";}
        @{ VarName = "NPM_CONFIG_CACHE"; VarValue = "c:\cache\npm\cache";}
        @{ VarName = "NUGET_PACKAGES"; VarValue = "c:\cache\nuget";}
        
    );
    EnvironmentVarsRemove = @(
        #@{ Name = ""; }
    );
}
$Config