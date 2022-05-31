## Basics

You'll probably need to download the fonts manually from Nerd Fonts. At some point I should just automate that

### Installation

For setup of a dev environment you can run `choco install dev.config -y` and it will install a lot of stuff that you'll want. Including Windows Terminal and PowerShell 7. 

### Setup

1. Copy and pase the contents of settings.json into the WindowsTerminal settings
2. Make sure the backgroundImage path is correct (it should be if your git repository is C:\git)
3. Download the fonts you want - probably the easiest way to do this is with `scoop.sh` (also see https://github.com/matthewjberger/scoop-nerd-fonts):
	a. `iwr -useb get.scoop.sh | iex`
	b. `scoop bucket add nerd-fonts`
	c. `scoop install sudo`
	d. `sudo scoop install FantasqueSansMono-NF`
	e. `sudo scoop install Inconsolata-NF`

4. Install some of the powershell stuff
	a. Oh-My-Posh:  `Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease`
	b. Posh-git: `Install-Module posh-git -Scope CurrentUser`
	b. Posh-SSH: `Install-Module -Name Posh-SSH`
5. Copy the powershell profile to location of $profile (~\Documents\WindowsPowerShell)