#!/bin/sh

set -e

# setup debs to handle non-free stuff
# it's possible to mess up your sources list if you run this more than once (e.g. if it fails)
# if it fails you should restore from the backup before re-running
if [ -f /etc/apt/sources.list.backup ]; then 
	# restore from backup
	cp /etc/apt/sources.list.backup /etc/apt/sources.list
else
	# make a backup
	cp /etc/apt/sources.list /etc/apt/sources.list.backup
fi
sed -i 's/bullseye main/bullseye main contrib non-free/g' /etc/apt/sources.list \
	&& sudo sed -i 's/bullseye-security main/bullseye-security main contrib non-free/g' /etc/apt/sources.list \
	&& sudo sed -i 's/bullseye-updates main/bullseye-updates main contrib non-free/g' /etc/apt/sources.list 

apt update 


# remove packages
echo "### Removing packages ###"
for x in aisleriot cheese empathy gnome-contacts gnome-mahjongg \
	gnome-disk-utility gnome-terminal gnome-screenshot gnome-mines \
	gnome-sudoku libreoffice-calc libreoffice-common libreoffice-draw \
	libreoffice-impress libreoffice-math libreoffice-writer modemmanager \
	thunderbird gdm3; do		
		echo "deleting $x"
		sudo apt-get -qq purge $x;
done

sudo apt-get -qq autoremove

# install the stuff
echo "### Installing the things"
apt-get --no-install-recommends install -y \
aptitude \
apt-file \
curl \
daemontools \
dos2unix \
fonts-powerline \
fzf \
git \
htop \
jq \
make \
moreutils \
mosh \
openssh-client \
openssh-server \
powerline \
ripgrep \
rsync \
pv \
tmux \
tree \
unattended-upgrades \
neovim \
zsh

echo "### Installing libs that are required for st/dwm"
apt-get --no-install-recommends install -y \
libx11-xcb-dev \
libxcb-res0-dev \
dh-autoreconf \
autotools-dev \
xutils-dev \
libfreetype-dev \
libxft-dev \
libharfbuzz-dev \
libxinerama-dev \
debconf-utils
