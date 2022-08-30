#!/bin/sh

set -e

# get distro codename
codename=$(lsb_release -cs)

# setup debs to handle non-free stuff
# sources help for when I forgot: https://wiki.debian.org/SourcesList
add-apt-repository "contrib" > /dev/null
add-apt-repository "non-free" > /dev/null

# add barrett repo
[ -f /etc/apt/sources.list.d/barrett.list ] && sudo rm /etc/apt/sources.list.d/barrett.list;
wget -O- -q https://apt.barrett.computer/apt.barrett.computer.gpg.key | apt-key add -
echo "deb https://apt.barrett.computer/debian $(codename) main" | tee /etc/apt/sources.list.d/barrett.list
[ ! -f /etc/apt/preferences.d/100barrett ] && printf "Package: *\nPin: origin apt.barrett.computer\nPin-Priority: 1001" | tee /etc/apt/preferences.d/100barrett

# remove existing brave key
[ -f /etc/apt/sources.list.d/brave-browser-release.list ] && sudo rm /etc/apt/sources.list.d/brave-browser-release.list;
# add brave key
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"| \
	tee /etc/apt/sources.list.d/brave-browser-release.list

# remove existing signal key
[ -f /etc/apt/sources.list.d/signal-xenial.list ] && sudo rm /etc/apt/sources.list.d/signal-xenial.list;
# add signal key
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | \
  tee /etc/apt/sources.list.d/signal-xenial.list
rm signal-desktop-keyring.gpg

# add testing/unstable because we like to live on the edge
echo 'deb http://deb.debian.org/debian testing main contrib non-free' | tee -a /etc/apt/sources.list.d/debian-testing.list
echo 'deb-src http://deb.debian.org/debian testing main contrib non-free' | tee -a /etc/apt/sources.list.d/debian-testing.list
echo 'deb http://deb.debian.org/debian unstable main contrib non-free' | tee -a /etc/apt/sources.list.d/debian-unstable.list
echo 'deb-src http://deb.debian.org/debian unstable main contrib non-free'  | tee -a /etc/apt/sources.list.d/debian-unstable.list

# set pin preferences - only install testing/unstable if I ask for it
[ ! -f /etc/apt/preferences.d/98testing ] && printf "Package: *\nPin: release a=testing\nPin-Priority: 100\n" | tee /etc/apt/preferences.d/98testing
[ ! -f /etc/apt/preferences.d/99unstable ] && printf "Package: *\nPin: release a=unstable\nPin-Priority: 100\n" | tee /etc/apt/preferences.d/99unstable

# increase apt cache limit
[ ! -f /etc/apt/apt.conf.d/99cache-limit.conf ] && echo 'APT::Cache-Limit "8388608";' | tee /etc/apt/apt.conf.d/99cache-limit.conf

apt-get update -qq

# remove packages
echo "### Removing packages ###"
for x in aisleriot cheese empathy gnome-contacts gnome-mahjongg \
	gnome-disk-utility gnome-terminal gnome-screenshot gnome-mines \
	gnome-sudoku libreoffice-calc libreoffice-common libreoffice-draw \
	libreoffice-impress libreoffice-math libreoffice-writer modemmanager \
	thunderbird gdm3 libxft-dev libxft2 xserver-xorg-video-intel; do		
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
libnotify-bin \
libpulse-dev \
libx11-xcb-dev \
libxcb-res0-dev \
libxft2 \
libxinerama-dev \
libxrandr-dev \
libxrender-dev \
mesa-utils \
phonon-backend-gstreamer-common \
qml-module-qtquick-controls \
qml-module-qtgraphicaleffects \
qml-module-qtmultimedia \
qtmultimedia5-dev \
xdotool \
xutils-dev

#installing a few libs that are different between buster and bullseye
[ "$codename" = "buster" ] && apt-get install -y --no-install-recommends libfreetype6-dev
[ "$codename" = "bullseye" ] && apt-get install -y --no-install-recommends libfreetype-dev


# install the apps you know and love
echo "### Installing the things"
apt-get install -y --no-install-recommends \
abook \
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
isync \
iw \
jq \
make \
moreutils \
mosh \
mpd \
mpc \
msmtp \
neomutt \
neovim \
net-tools \
notmuch \
openssh-client \
openssh-server \
pass \
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
urlview \
wireless-tools \
zsh


# only do this after we've installed everything
apt-get autoremove -qq
