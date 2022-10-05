## Dotfiles ##

This repo contains my dotfiles. I've decided to go with the bare repository approach (at least for linux).  

All the os specific files into their own branches (linux/windows). 

## Linux Setup ##

1. From a fresh install of Debian 10/11, open a console (Ctrl-Alt-F2)
2. Login as the user you created when installing the os
3. Change to root: `su -`
4. Install curl: `apt install -y curl`
5. Run the start-here script: `curl -Lks https://raw.githubusercontent.com/shiitake/.cfg/linux/.local/bin/setup/go.sh | bash -s username`
6. Wait for everything to finish.
7. Once it has completed reboot and login: `sudo reboot`


## Windows ##

1. Create git repository location: c:\git, clone this repo `git clone git@github.com:shiitake/.cfg.git` and checkout the windows branch `get checkout windows`

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

7. Install PowerTemplate `Import-Module -Name C:\git\.cfg\PowerShell\PowerTemplate\ -Verbose`

8. Setup neovim:
* copy init.vim to `~\AppData\Local\nvim\init.vim`
* install vim-plug: `iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni $HOME/vimfiles/autoload/plug.vim -Force`

## Todo ##
* Move this stuff to it's own script
* Be smarter. 

NOTE: I've found a few examples of how people have setup their window's dotfile. 

https://github.com/jayharris/dotfiles-windows
https://dev.to/deusmxsabrina/getting-started-with-dotfile-management-with-git-on-windows-3jm0