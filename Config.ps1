$Config = @{
    DefaultRunSteps = @(
        "Install-Base",
        "Install-Choco",
        "Configure-Folders",
        "Install-ChocoPackages",
        "Configure-EnvironmentVariables",
        "Install-Ps7Modules",
        "Install-ZipPackages",
        "Install-NpmGlobalTools",
        "Install-VsCodeExtensions",
        "Install-WSL.ps1",
        "Configure-GitProfile"
    );
    LocalPaths = @(
        'c:\Repos',
        'c:\cache\npm',
        'c:\cache\nuget',
        'c:\cache\software',
        'c:\tools',
        'C:\Software'
    );
    UserAccount = "AzureAD\user.name@domain.com";
    WSLDistroPackageURI = "";
    CacheRootLocation = 'c:\cache';
    SoftwarePath = 'C:\Software';
    ToolsPath = 'C:\tools';
    LocalReposFolder = "C:\repos";
    PSProfileFilename = "Microsoft.PowerShell_profile.ps1";
    Git = @{ Username = "User Name"; Email = "user.name@domain.com"; Prune = "true";}
    ChocoPackages = @(
        @{ Name = "powershell-core" };
        @{ Name = "7zip" };
        @{ Name = "vscode" };
        @{ Name = "git" };
        @{ Name = "microsoft-edge"; };
        @{ Name = "docker-desktop" };
        @{ Name = "azure-data-studio"; };
        @{ Name = "sql-server-management-studio"; };
        @{ Name = "nodejs-lts"; };
        @{ Name = "dotnet-6.0-sdk"; };        
        @{ Name = "curl" };
        @{ Name = "Nuget.CommandLine"; };
        @{ Name = "microsoft-openjdk11"; };
        @{ Name = "jmeter"; Version = "5.2.1"; Args="--ignore-dependencies";};
        @{ Name = "maven"; };
        @{ Name = "kubernetes-cli"; };
        @{ Name = "kubernetes-helm"; };
        @{ Name = "azure-cli"; };
        @{ Name = "azcopy10"; };
        @{ Name = "azure-functions-core-tools"; };
        @{ Name = "servicebusexplorer"; };
        @{ Name = "microsoftazurestorageexplorer"; };
        @{ Name = "visualstudio2022professional"; };
        @{ Name = "visualstudio2022-workload-azure"; };
        @{ Name = "visualstudio2022-workload-manageddesktop"; };
        @{ Name = "visualstudio2022-workload-netcoretools"; };
        @{ Name = "visualstudio2022-workload-netweb"; };
        @{ Name = "visualstudio2022-workload-node"; };
        @{ Name = "visualstudio2022-workload-data"; };
        @{ Name = "microsoft-windows-terminal"; };
    );
    NpmGlobalTools = @(
        "npm",
        "gulp-cli@2.3.0",
        "grunt-cli@1.4.3",
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
        "ms-vscode-remote.remote-wsl",
        "ms-vscode-remote.remote-containers",
        "redhat.vscode-yaml",
        "eriklynd.json-tools",
        "mariusalchimavicius.json-to-ts"
    );
    Ps7InstallModuleCommands = @(
        "Install-Module -Name Az -AllowClobber -Scope AllUsers -Verbose -Force",
        "Install-Module -Name PSScriptAnalyzer",
        "Install-Module -Name posh-git",
        "Install-Module -Name oh-my-posh",
        "Install-Module -Name PSReadLine -Scope CurrentUser"
    );
    PipInstallCommands = @(
        # @{ Exec = "pip3.exe"; Args = @("install","mkdocs-exclude"); }
        # @{ Exec = "pip.exe"; Args = @("install","mkdocs-material==4.6.3"); }
    );
    ZipInstallSoftware = @(
    );
    ZipInstallTools =  @(
    );
    Shortcuts = @(
    );
    CommonFiles = @(
    );
    EnvironmentPathAdd = @(
        @{ VarValue = "X:\cache\user\npm\prefix"; Scope = "User"; }
        @{ VarValue = "C:\Python39"; Scope = "All"; }
        @{ VarValue = "C:\Python39\Scripts"; Scope = "All"; }
    );
    EnvironmentPathRemove = @(
    );
    #Value for Scope can be "User, Machine, All" where User = User + Process; Machine = Machine + Process; All = all 3 scopes are applied.
    EnvironmentVarsAdd = @(
        @{ VarName = "NPM_CONFIG_PREFIX"; VarValue = "c:\cache\npm\prefix"; Scope = "All"; }
        @{ VarName = "NPM_CONFIG_CACHE"; VarValue = "c:\cache\npm\cache"; Scope = "All"; }
        @{ VarName = "NUGET_PACKAGES"; VarValue = "c:\cache\nuget"; Scope = "All"; }        
    );
    EnvironmentVarsRemove = @(
        #@{ Name = ""; }
    );
}
$Config
