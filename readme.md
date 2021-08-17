## Remind Me ##

The point of this readme is to remind myself what I need to do to get these dot files to work. 

It would be awesome if I would just remember this stuff but for now this will have to suffice. 

## Linux Setup ##

1. Create a git directory in your home directory:  `mkdir -p ~/git`
2. Clone this repository in that directory: `git clone git://github.com/shiitake/.cfg ~/git/.cfg`
3. Pull all the git submodules by running the following:    `git submodule update --init`
4. Install the following packages: 
	curl
	zsh
	powerline
	powerline fonts
	dos2unix
	docker
	firefox


5. Copy the .config and .local folders to your local directory
  `cp -R /home/shannon/git/.cfg/.config /home/shannon`
  `cp -R /home/shannon/git/.cfg/.local /home/shannon`

6. Fix line-ending issues by running dos2unix on all the plaintext files
  `find ./.config -maxdepth 2 -type f -exec dos2unix {} \;`
  `find ./.local -maxdepth 2 -type f -exec dos2unix {} \;`

7. Create the following symlinks to the appropriate files/directories

  .zprofile -> `ln -s .config/shell/profile .zprofile`
  .xprofile -> `ln -s .config/x11/xprofile .xprofile`

If you screw these up you can use the `unlink` command to remove the symlink. 

8. Set Zsh to default shell `chsh -s $(which zsh)` 


### ST and DWM ###

Installing ST is pretty straightforward - just clone the git repository and install
`git clone https://github.com/LukeSmithxyz/st` 

#### Instructions for setting up dwm from lukesmith's fork 
1. Install libxft-bgra on debian/ubuntu 
  * ~~Install missing dependancies: `apt install libx11-xcb-dev libxcb-res0-dev dh-autoreconf autotools-dev xutils-dev` ~~
  * ~~Clone repo from github:   `git clone https://github.com/uditkarode/libxft-bgra` ~~
  * ~~Follow build instructions from repo ~~
  * Add barrett.computer repository:
    * add the following line to /etc/apt/sources.list
      deb https://apt.barrett.computer/debian/ buster main
    * make sure this repo takes priority by editing /etc/apt/preferences
      ```
      Package: *
      Pin: origin apt.barrett.computer
      Pin-Priority: 1001
      ```
    * import the gpg key
      `wget -O - -q https://apt.barrett.computer/apt.barrett.computer.gpg.key | sudo apt-key add -`
    * update the db:
      `apt update`
    * install the package:
      `apt install libxft2`
    * re-install ST 
2. Clone repo from github:   git clone https://github.com/LukeSmithxyz/dwm 
3. Setup dwmblocks - tbd


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



