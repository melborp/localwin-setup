# Configuration and setup of my local windows machines

The plan is to collect automation scripts and configurations for setting up my local windows machines here. If someone else finds it useful, then its fair picking and happy to get feedback and ideas from community on how to do it better. I dont have everything automated yet.
Its an experimentation corner of how to automate local machine setup.

# The cornerstone are these technologies

- Chocolatey
- Powershell and Powershell Core 

# How to run it?

1. Create your own config.ps1 to define the choco packages, npm packages, zip downloads, etc that you want to configure.
2. Run as Admin in powershell 
   ```
   .\Setup-Machine.ps1 -ConfigFilePath .\Config.ps1
   ```

# Running partially
- Run as Admin in powershell 
```
.\Setup-Machine.ps1 -ConfigFilePath .\Config.ps1 -RunSteps @('Configure-Profile')
```

OR

```
$Config = .\Config.ps1
.\Steps\Configure-Profile.ps1 -Config $Config
```

# Updating current configuration with new versions

Just re-run Setup-Machine.ps1.

> **Note** If you have Version attribute specified for package, then you need to change the version manually in `Config.ps1` to cause it to get upgraded. 

> **Note** For Side-By-Side installation  such as dotnetcoresdk you need to add a new item into the array with the new version, since you normally want to keep the old versions.
