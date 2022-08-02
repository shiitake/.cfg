#!/bin/sh

set -e

# get distro codename
codename=$(grep "CODENAME" /etc/os-release | cut -d '=' -f 2)

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
sed -i "s|${codename} main|${codename} main contrib non-free|g" /etc/apt/sources.list \
	&& sudo sed -i "s|${codename}-security main|${codename}-security main contrib non-free|g" /etc/apt/sources.list \
	&& sudo sed -i "s|${codename}-updates main|${codename}-updates main contrib non-free|g" /etc/apt/sources.list 

# Add brave key
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"| tee /etc/apt/sources.list.d/brave-browser-release.list

# add signal key
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | \
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
rm signal-desktop-keyring.gpg

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

echo "### Installing libs that are required for st/dwm, etc"
apt-get install -y --no-install-recommends \
autotools-dev \
compton \
debconf-utils \
dh-autoreconf \
fonts-inconsolata \
fonts-linuxlibertine \
fonts-noto \
fonts-powerline \
fonts-symbola \
gstreamer1.0-libav \
gstreamer1.0-plugins-good \
libd3dadapter9-mesa \
libfontconfig1-dev \
libharfbuzz-dev \
libpulse-dev \
libx11-xcb-dev \
libxcb-res0-dev \
libxinerama-dev \
libxrender-dev \
mesa-utils \
phonon-backend-gstreamer-common \
qml-module-qtquick-controls \
qml-module-qtgraphicaleffects \
qml-module-qtmultimedia \
qtmultimedia5-dev \
suckless-tools \
xdotool \
xutils-dev

#installing a few libs that are different between buster and bullseye
[ "$codename" = "buster" ] && apt-get install -y --no-install-recommends libfreetype6-dev
[ "$codename" = "bullseye" ] && apt-get install -y --no-install-recommends libfreetype-dev


# install the apps you know and love
echo "### Installing the things"
apt-get install -y --no-install-recommends \
aptitude \
apt-file \
apt-transport-https \
brave-browser \
curl \
daemontools \
dos2unix \
feh \
fzf \
git \
htop \
iw \
jq \
make \
moreutils \
mosh \
mpd \
mpc \
neovim \
net-tools \
openssh-client \
openssh-server \
powerline \
pulsemixer \
ranger \
ripgrep \
rsync \
pv \
shellcheck \
signal-desktop \
task-spooler \
tmux \
tree \
unattended-upgrades \
wireless-tools \
zsh


# only do this after we've installed everything
apt-get autoremove -qq
