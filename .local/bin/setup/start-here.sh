#!/bin/sh

set -e

##start here

name=$(whoami)
home="/home/$name"
repldir="$home/git"
backup=$home/.config/config-backup

sudo apt-get install -qq git curl

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
git clone -b linux --config status.showUntrackedFiles=no --bare https://github.com/shiitake/.cfg.git $HOME/git/.cfg

# move conflicting files
config checkout linux 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv -f {} $backup/{}
config checkout linux

# install packages now
sudo sh $HOME/.local/bin/setup/packages.sh

# setup everything else
sh $HOME/.local/bin/setup/setup.sh

# update permissions to something more sensible
[ -f "/etc/sudoers.d/$name" ] && mv "/etc/sudoers.d/$name" /etc/sudoers.d/tmp
echo "$name ALL=(ALL) NOPASSWD: /usr/sbin/shutdown,/usr/sbin/reboot,/usr/sbin/halt, /usr/bin/systemctl suspend,/usr/bin/mount,/usr/bin/mount,/usr/bin/apt update, /usr/bin/apt-get update, /usr/bin/apt install -y,/usr/bin/apt-get install -y,/usr/bin/apt search,/usr/bin/apt-get search,/usr/sbin/iwlist,/usr/sbin/iw, /usr/sbin/ifconfig" | tee "/etc/sudoers.d/$name"
rm -f /etc/sudoers.d/tmp
