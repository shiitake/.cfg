## Basics

You'll probably need to download the fonts manually from Nerd Fonts. At some point I should just automate that

### Setup

1. Copy and pase the contents of settings.json into the WindowsTerminal settings
2. Make sure the backgroundImage path is correct (it should be if your git repository is C:\git)
3. Download the fonts you want - probably the easiest way to do this is with `scoop.sh` (also see https://github.com/matthewjberger/scoop-nerd-fonts):
	a. `iwr -useb get.scoop.sh | iex`
	b. `scoop bucket add nerd-fonts`
	c. `scoop install sudo`
	d. `sudo scoop install FantasqueSansMono-NF`
	e. `sudo scoop install Inconsolata-NF`
4. Copy the powershell profile to ~/Documents/WindowsPowerShell/
