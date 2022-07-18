#!/bin/sh

set -e

# running this as root makes things a lot more complicated. 
# it might be worth it in the future to do that but for now
# we'll just make sure the user has root permissions and that
# that sudo doesn't require a password. 

name=$(whoami)
home="/home/$name"
repldir="$home/git"
backup=$home/.config/config-backup

[ ! -d "$repldir" ] && mkdir "$repldir"
[ ! -d "$backup" ] && mkdir "$backup"

# cleam up home and remove extra dotfiles that we're not going to use
for x in .bash_profile .bash_login .bash_logout .bashrc .profile .xprofile .xinitrc; do
	[ -f $x ] && mv $x "$backup/$x"
done

# maybe setup repo here

# set zsh as default
# this requires a password - still need to figure that out
chsh -s $(which zsh)

# download joypixel font
sudo wget -O /usr/share/fonts/truetype/JoyPixels.ttf https://cdn.joypixels.com/arch-linux/font/6.6.0/joypixels-android.ttf
fc-cache -f -v

# install XFT
echo "installing XFT"
cd $repldir
git clone https://gitlab.freedesktop.org/xorg/lib/libxft.git
cd libxft
sh autogen.sh --sysconfdir=/etc --prefix=/usr --mandir=/usr/share/man
sudo make install
cd $repldir
sudo rm -rf "$repldir/libxft"

# install st
echo "installing ST"
cd $repldir
git clone https://github.com/LukeSmithxyz/st
cd st
sudo make install
cd $repldir


# install dwm
echo "installing dwm"
git clone https://github.com/LukeSmithxyz/dwm
cd dwm
sudo make install
cd $repldir

# install demu

# install dwm blocks


# install slim display manager
echo "installing slim display manager"
sudo debconf-set-selections <<EOF
slim  shared/default-x-display-manager select slim
EOF

DEBIAN_FRONTEND=noninteractive sudo apt-get -qq install slim