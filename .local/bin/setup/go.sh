#!/bin/sh

set -e

#This script is going to setup pre-rec stuff and needs to be run as root
[ "$EUID" -ne 0 ] && echo "This script must run as root user" && exit 1

name=$1
[ -z "$name" ] && echo "Please provide a username to this script" && exit 1

# check if running the right os/disto
# this has only been tested on debian running bullseye or buster
codename=$(lsb_release -cs)
[ ! "$codename" = "buster" ] && [ ! "$codename" = "bullseye" ] && echo "This script only works on Debian Buster or Bullseye. You're running $codename" && exit 1

# setup user permissions
echo "$name ALL=(ALL) NOPASSWD:ALL" | tee "/etc/sudoers.d/$name"

# install pre-req packages
apt-get install -y git sudo software-properties-common

home="/home/$name"
repldir="$home/git"
backup=$home/.config/config-backup

# set up repo
[ ! -d "$repldir" ] && sudo -u $name mkdir -p "$repldir"
[ ! -d "$backup" ] && sudo -u $name mkdir -p "$backup"

# clean up home and remove extra dotfiles that we're not going to use
echo "### Cleaning up extra dotfiles ###"
for x in .bash_profile .bash_login .bash_logout .bashrc .profile .xprofile .xinitrc; do
	[ -f "$home/$x" ] && mv "$home/$x" "$backup/$x"
done

# make sure that alias is recognized in the script. 
echo "### Cloning repository ###"
shopt -s expand_aliases
alias config='/usr/bin/git --git-dir=$repldir/.cfg --work-tree=$HOME'
sudo -u $name echo ".cfg" >> "$home/.gitignore"
sudo -u $name git clone -b linux --config status.showUntrackedFiles=no --bare https://github.com/shiitake/.cfg.git $home/git/.cfg

# move conflicting files
sudo -u $name config checkout linux 2>&1 | grep -E "\s+\." | awk '{print $1}' | xargs -I{} sh -c "cp --parents {} $backup; rm {};"
sudo -u $name config checkout linux