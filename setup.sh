#!/bin/sh

set -e


# set zsh as default
chsh -s $(which zsh)

# download joypixel font
wget -O /usr/share/fonts/truetype/JoyPixels.ttf https://cdn.joypixels.com/arch-linux/font/6.6.0/joypixels-android.ttf
fc-cache -f -v

# install XFT
echo "installing XFT"
git clone https://gitlab.freedesktop.org/xorg/lib/libxft.git
cd libxft
sh autogen.sh --sysconfdir=/etc --prefix=/usr --mandir=/usr/share/man
make install
cd ..
rm -rf libxft

# install st
echo "installing ST"
git clone https://github.com/LukeSmithxyz/st
cd st
make install
cd ..
rm st


# install dwm
echo "installing dwm"
git clone https://github.com/LukeSmithxyz/dwm
cd dwm
make install
cd ..
rm dwm

# install slim display manager
echo "installing slim display manager"
debconf-set-selections <<EOF
slim  shared/default-x-display-manager select slim
EOF

DEBIAN_FRONTEND=noninteractive apt-get -qq install slim

# setup bare repo for dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# this will help avoid recurion problems
echo ".cfg" >> .gitignore
git clone --bare https://github.com/shiitake/.cfg.git $HOME/.cfg

#move any conflicting files to a backup location (they can be deleted later)
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

config checkout
config config --local status.showUntrackedFiles no