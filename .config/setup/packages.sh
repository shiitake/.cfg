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

# Add brave key
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"| tee /etc/apt/sources.list.d/brave-browser-release.list

apt-get update -qq

# remove packages
echo "### Removing packages ###"
for x in aisleriot cheese empathy gnome-contacts gnome-mahjongg \
	gnome-disk-utility gnome-terminal gnome-screenshot gnome-mines \
	gnome-sudoku libreoffice-calc libreoffice-common libreoffice-draw \
	libreoffice-impress libreoffice-math libreoffice-writer modemmanager \
	thunderbird gdm3 libxft-dev libxft2; do		
		echo "deleting $x"
		apt-get purge -qq $x;
done

apt-get autoremove -qq

# install the stuff
echo "### Installing the things"
apt-get install -y --no-install-recommends \
aptitude \
apt-file \
apt-transport-https \
brave-browser \
curl \
daemontools \
dos2unix \
fonts-inconsolata \
fonts-linuxlibertine \
fonts-noto \
fonts-powerline \
fonts-symbola \
fzf \
git \
htop \
jq \
make \
moreutils \
mosh \
mpd \
mpc \
openssh-client \
openssh-server \
powerline \
ripgrep \
rsync \
pv \
shellcheck \
taskspooler \
tmux \
tree \
unattended-upgrades \
neovim \
zsh

echo "### Installing libs that are required for st/dwm"
apt-get install -y --no-install-recommends \
autotools-dev \
compton \
debconf-utils \
dh-autoreconf \
gstreamer1.0-libav \
gstreamer1.0-plugins-good \
libfreetype-dev \
libharfbuzz-dev \
libx11-xcb-dev \
libxcb-res0-dev \
libxinerama-dev \
phonon-backend-gstreamer-common \
qml-module-qtquick-controls \
qml-module-qtgraphicaleffects \
qml-module-qtmultimedia \
qtmultimedia5-dev \
xutils-dev


