#!/bin/sh

set -e

# setup debs to handle non-free stuff
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
sudo sed -I -- 's/bullseye main/bullseye main contrib non-free/g' /etc/apt/sources.list \
	&& sudo sed -I -- 's/bullseye-security main/bullseye-security main contrib non-free/g' /etc/apt/sources.list \ 
	&& sudo sed -I -- 's/bullseye-updates main/bullseye-updates main contrib non-free/g' /etc/apt/sources.list 

sudo apt update 


# remove packages
for x in aisleriot cheese empathy gnome-contacts gnome-mahjongg \
	gnome-disk-utility gnome-terminal gnome-screenshot gnome-mines \
	gnome-sudoku libreoffice-calc libreoffice-common libreoffice-draw \
	libreoffice-impress libreoffice-math libreoffice-writer modemmanager \
	thunderbird gdm3; do
		if [ is_installed x ]; then 
			sudo apt-get -y purge x; 
		fi

exec apt-get -y autoremove

is_installed() {
	dpkg -s $1 &> /dev/null
	if [ $? -eq 0 ]; then
	    true
	else
	    false
	fi
}
