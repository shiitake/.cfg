## Remind Me ##

The point of this readme is to remind myself what I need to do to get these dot files to work. 

It would be awesome if I would just remember this stuff but for now this will have to suffice. 


## Windows ##

1. Create git repository location: c:\git

2. Enable Window's Subsystem for Linux (WSL). From administrator PowerShell run `wsl --install`. This will require a reboot to fully complete

2. Install Chocolatey - 
  `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`

3. Install Chocolatey packages from an elevated command prmopt
  * For dev stuff: `choco install -y .\choco\dev.config`
  * For basic stuff: `choco install -y .\choco\base.config`

4. Copy and paste the contents of settings.json into the WindowsTerminal settings
  * Make sure the backgroundImage path is correct (it should be if your git repository is C:\git) 

  ```
  $termlocation='\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\'
  $destination= join-path -path $([System.Environment]::ExpandEnvironmentVariables("LOCALAPPDATA%")) -childpath $termlocation
  Copy-Item -Path .\Windows\settings.json -Destination $destination
  ```

5. Download the fonts you want - probably the easiest way to do this is with `scoop.sh` (also see https://github.com/matthewjberger/scoop-nerd-fonts):
<<<<<<< Updated upstream
	a. `iwr -useb get.scoop.sh | iex`
	b. `scoop bucket add nerd-fonts`
	c. `scoop install sudo`
	d. `sudo scoop install FantasqueSansMono-NF`
	e. `sudo scoop install Inconsolata-NF`
6. Copy the powershell profile to correct location: 

```
$profileDir = Split-Path -parent $profile
New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue

Copy-Item -Path ./*.ps1 -Destination $profileDir -Exclude "bootstrap.ps1"

Remove-Variable profileDir
```

>>>>>>> Stashed changes
7. Install PowerTemplate `Import-Module -Name C:\git\.cfg\PowerShell\PowerTemplate\ -Verbose`

8. Setup neovim:
* copy init.vim to `~\AppData\Local\nvim\init.vim`
* install vim-plug: `iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni $HOME/vimfiles/autoload/plug.vim -Force`


## Todo ##
* Move this stuff to it's own script
* Be smarter. 


I've found a few examples of how people have setup their window's dotfile. 

https://github.com/jayharris/dotfiles-windows
https://dev.to/deusmxsabrina/getting-started-with-dotfile-management-with-git-on-windows-3jm0


bootstrap.ps1: copies profile and common powershell files to profile location 

install.ps1: 

