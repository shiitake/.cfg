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

# set zsh as default
sudo chsh -s $(which zsh) "$name" >/dev/null 2>&1

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
git clone https://github.com/shiitake/st.git
cd st
sudo make install
cd $repldir

# install dwm
echo "installing dwm"
git clone https://github.com/shiitake/dwm.git
cd dwm
sudo make install
cd $repldir

# install demu
echo "installing dmenu"
git clone https://github.com/shiitake/dmenu.git
cd dmenu
sudo make install
cd $repldir

# install dwm blocks
echo "dwm blocks"
git clone https://github.com/shiitake/dwmblocks.git
cd dwmblocks
sudo make install
cd $repldir



# install slim display manager
echo "installing slim display manager"
sudo debconf-set-selections <<EOF
slim  shared/default-x-display-manager select slim
EOF

DEBIAN_FRONTEND=noninteractive sudo apt-get -qq install slim

sudo cp $home/.config/slim/slim.conf /etc/slim.conf
sudo sp -r $home/.config/slim/themes/ /usr/share/slim/themes

# copy xsession
sudo cp $home/.config/x11/xsession.desktop /usr/share/xsessions/xsession.desktop

# create symlinks to xsession stuff maybe? 
ln -s $home/.config/shell/profile $home/.zprofile
ln -s $home/.config/x11/xsession $home/.xsession
ln -s $home/.config/x11/xsessionrc $home/.xsessionrc

