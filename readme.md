## Remind Me ##

The point of this readme is to remind myself what I need to do to get these dot files to work. 

It would be awesome if I would just remember this stuff but for now this will have to suffice. 

1. Create a git directory in your home directory:  `mkdir -p ~/git`
2. Clone this repository in that directory: `git clone git://github.com/shiitake/.cfg ~/git/.cfg`
3. Pull all the git submodules by running the following:    `git submodule update --init`
4. Install the following packages: 
	curl
	zsh
	powerline
	powerline fonts
	zsh
	docker
	firefox

5. Create the following symlinks to the appropriate files/directories

.vim ->  `ln -s /home/shannon/git/.cfg/.vim /home/shannon/.vim`  
.vimrc -> `ln -s /home/shannon/git/.cfg/.vimrc /home/shannon/.vimrc`  
.bashrc -> `ln -s /home/shannon/git/.cfg/.bashrc /home/shannon/.bashrc`  
.zshrc -> `ln -s /home/shannon/git/.cfg/.zshrc /home/shannon/.zshrc`  
.tmux.conf -> `ln -s /home/shannon/git/.cfg/tmux.conf /home/shannon/tmux.conf`  

If you screw these up you can use the `unlink` command to remove the symlink. 

6. Set Zsh to default shell `chsh -s $(which zsh)` 


### ST and DWM ###

Installing ST is pretty straightforward - just clone the git repository and install
`git clone https://github.com/LukeSmithxyz/st` 

#### Instructions for setting up dwm from lukesmith's fork 
1. Install libxft-bgra on debian/ubuntu 
  * Install missing dependancies: `apt install libx11-xcb-dev libxcb-res0-dev dh-autoreconf autotools-dev xutils-dev` 
  * Clone repo from github:   `git clone https://github.com/uditkarode/libxft-bgra` 
  * Follow build instructions from repo 

2. Clone repo from github:   git clone https://github.com/LukeSmithxyz/dwm 
3. Setup dwmblocks - tbd



### Todo ###
* Figure out how to incorporate your ST build
* Be smarter. 



