## Remind Me ##

The point of this readme is to remind myself what I need to do to get these dot files to work. 

It would be awesome if I would just remember this stuff but for now this will have to suffice. 

I've moved all the os specific files into their own branches (Linux/Windows). 

## Linux Setup ##

1. From a fresh install of Debian 10/11, open a console (Ctrl-Alt-F2)
2. Login as the user you created when installing the os
3. Change to root: `su -`
4. Install curl: `apt install -y curl`
5. Run the start-here script: `curl -Lks https://raw.githubusercontent.com/shiitake/.cfg/linux/.local/bin/setup/go.sh | bash -s username`
6. Wait for everything to finish.
7. Once it has completed reboot and login: `sudo reboot`


## Windows ##

1. Create git repository location: c:\git

2. Install Chocolatey - 
  `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`

3. Install Chocolatey packages: 
  * `choco install powershell-core`
  * `choco install microsoft-windows-terminal`

4. Copy and paste the contents of settings.json into the WindowsTerminal settings
  * Make sure the backgroundImage path is correct (it should be if your git repository is C:\git) 

5. Download the fonts you want - probably the easiest way to do this is with `scoop.sh` (also see https://github.com/matthewjberger/scoop-nerd-fonts):
	a. `iwr -useb get.scoop.sh | iex`
	b. `scoop bucket add nerd-fonts`
	c. `scoop install sudo`
	d. `sudo scoop install FantasqueSansMono-NF`
	e. `sudo scoop install Inconsolata-NF`
6. Copy the powershell profile to ~/Documents/WindowsPowerShell/
7. Install PowerTemplate `Import-Module -Name C:\git\.cfg\PowerShell\PowerTemplate\ -Verbose`

## Todo ##
* Move this stuff to it's own script
* Be smarter. 



