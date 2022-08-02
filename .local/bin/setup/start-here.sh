#!/bin/sh

set -e

##start here
# check if running the right os/disto
# this has only been tested on debian running bullseye or buster
codename=$(grep "CODENAME" /etc/os-release | cut -d '=' -f 2)
[ ! "$codename" = "buster" ] && [ ! "$codename" = "bullseye" ] && echo "This script only works on Debian Buster or Bullseye. You're running $codename" && exit 1

name=$(whoami)
home="/home/$name"
repldir="$home/git"
backup=$home/.config/config-backup

sudo apt-get install -qq git curl sudo

[ ! -d "$repldir" ] && mkdir -p "$repldir"
[ ! -d "$backup" ] && mkdir -p"$backup"

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
[ -f "/etc/sudoers.d/$name" ] && sudo mv "/etc/sudoers.d/$name" /etc/sudoers.d/tmp
echo "$name ALL=(ALL:ALL) ALL, NOPASSWD:/usr/sbin/shutdown,/usr/sbin/reboot,/usr/sbin/halt, /usr/bin/systemctl suspend,/usr/bin/mount,/usr/bin/mount,/usr/bin/apt update, /usr/bin/apt-get update, /usr/bin/apt install -y,/usr/bin/apt-get install -y,/usr/bin/apt search,/usr/bin/apt-get search,/usr/sbin/iwlist,/usr/sbin/iw, /usr/sbin/ifconfig" | sudo tee "/etc/sudoers.d/$name"
sudo rm -f /etc/sudoers.d/tmp
