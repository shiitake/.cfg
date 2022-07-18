#!/bin/sh

set -e

##start here

name=$(whoami)
home="/home/$name"
repldir="$home/git"
backup=$home/.config/config-backup

sudo apt install -qq git

[ ! -d "$repldir" ] && mkdir "$repldir"
[ ! -d "$backup" ] && mkdir "$backup"

# cleam up home and remove extra dotfiles that we're not going to use
for x in .bash_profile .bash_login .bash_logout .bashrc .profile .xprofile .xinitrc; do
	[ -f $x ] && mv $x "$backup/$x"
done

# make sure that alias is recognized in the script. 
shopt -s expand_aliases
alias config='/usr/bin/git --git-dir=$repldir/.cfg --work-tree=$HOME'
echo ".cfg" >> .gitignore
git clone --config status.showUntrackedFiles=no --bare https://github.com/shiitake/.cfg.git $HOME/git/.cfg

# move conflicting files
config checkout linux 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $backup/{}
config checkout linux