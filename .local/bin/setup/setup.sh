#!/bin/sh

set -e

# running this as root makes things a lot more complicated. 
# it might be worth it in the future to do that but for now
# we'll just make sure the user has root permissions and that
# that sudo doesn't require a password. 

name=$(whoami)
home="/home/$name"
repldir="$home/git"

[ ! -d "$repldir" ] && mkdir -p "$repldir"


# set zsh as default
sudo chsh -s $(which zsh) "$name" >/dev/null 2>&1

# download joypixel font
sudo wget -O /usr/share/fonts/truetype/JoyPixels.ttf https://cdn.joypixels.com/arch-linux/font/6.6.0/joypixels-android.ttf
fc-cache -f -v

# the patched version of libxft2 (2.3.2-3+zancl1) should already be installed from the barrett.computer repo
# by building and installing from source we'll get more up to date version and it will satisfy any 
# package dependencies for XFT.

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
echo "installing dwm blocks"
git clone https://github.com/shiitake/dwmblocks.git
cd dwmblocks
sudo make install
cd $repldir


# install slock
echo "installing slock "
# installing these dependencies here to make sure that it doesn't break XFT
sudo apt-get install -qq libimlib2-dev

git clone https://github.com/shiitake/slock.git
cd slock
sudo make clean install
cd $repldir

# install mutt-wizard
git clone https://github.com/LukeSmithxyz/mutt-wizard
cd mutt-wizard
sudo make install
cd $repldir

# setup screenlock image
[ ! -d /usr/local/share/wallpaper ] && sudo mkdir /usr/local/share/wallpaper
sudo cp $home/.config/wallpaper/positive.png /usr/local/share/wallpaper/screen-lock.png

# install SDDM display manager
echo "installing slim display manager"
sudo debconf-set-selections <<EOF
sddm  shared/default-x-display-manager select sddm
EOF

DEBIAN_FRONTEND=noninteractive sudo apt-get install -qq sddm

[ ! -d /etc/sddm.conf.d ] && sudo mkdir /etc/sddm.conf.d
sudo cp $home/.config/sddm/sddm.conf /etc/sddm.conf.d/sddm.conf

# install sddm theme
echo "installing sddm theme"
cd $repldir
git clone https://github.com/3ximus/aerial-sddm-theme.git
sudo mv aerial-sddm-theme /usr/share/sddm/themes



# copy xsession
[ ! -d /usr/share/xsessions ] && sudo mkdir /usr/share/xsessions
sudo cp $home/.config/x11/xsession.desktop /usr/share/xsessions/xsession.desktop

# create symlinks to xsession stuff maybe? 
[ ! -L $home/.zprofile ] && ln -s $home/.config/shell/profile $home/.zprofile
[ ! -L $home/.xsession ] && ln -s $home/.config/x11/xsession $home/.xsession
[ ! -L $home/.xsessionrc ] && ln -s $home/.config/x11/xsessionrc $home/.xsessionrc

# install vim plug
[ ! -f $home/.local/share/nvim/site/autoload/plug.vim ] && \
curl -fLo "$home/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c "PlugInstall|q|q"

# setup gpg
[ ! -d $home/.local/share/gnupg  ] && mkdir $home/.local/share/gnupg
chmod 600 $home/.local/share/gnupg/*
chmod 700 $home/.local/share/gnupg
# todo add ability to create gpg key automatically
# cat >keyfile <<EOF
# %echo Generating a default key
# Key-Type: default
# Subkey-Type: default
# Name-Real: My Name
# Name-Comment: 
# Name-Email: my@email.com
# Expire-Date: 0
# Passphrase: $passphrase
# # Do a commit here, so that we can later print "done"
# %commit
# %echo done
# EOF
#
# gpg --batch --generate-key keyfile

# cleanup
# Fix line-ending issues by running dos2unix on all the plaintext files
# excluding things in the pulse directory and image files
find $home/.config -maxdepth 2 -type f \( ! -path "*pulse*" \) \( ! -iname "*.png" \) -exec dos2unix -f {} \;
find $home/.local -maxdepth 2 -type f \( ! -path "*pulse*" \) \( ! -iname "*.png" \) -exec dos2unix -f {} \;

# remove any left over bash stuff
rm -f $home/.bash*

# set default theme to base16
defaultTheme=base16
cp "$home/.config/theme/$defaultTheme" "$home/.config/theme/default"
cp "$home/.config/wallpaper/base16.png" "$home/.config/theme/default.png"

