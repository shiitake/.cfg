## Remind Me ##

The point of this readme is to remind myself what I need to do to get these dot files to work. 

It would be awesome if I would just remember this stuff but for now this will have to suffice. 

1. Create a git directory in your home directory:  `mkdir -p ~/git`
2. Clone this repository in that directory: `git clone git://github.com/shiitake/.cfg ~/git/.cfg`
3. Pull all the git submodules by running the following:    `git submodule update --init`
4. Install the following packages: 
	curl
	zsh
	i3
	powerline
	powerline fonts
	zsh
	docker
	firefox

4. Create the following symlinks to the appropriate files/directories

.vim ->  `ln -s /home/shannon/git/.cfg/.vim /home/shannon/.vim`  
.vimrc -> `ln -s /home/shannon/git/.cfg/.vimrc /home/shannon/.vimrc`  
.bashrc -> `ln -s /home/shannon/git/.cfg/.bashrc /home/shannon/.bashrc`  
.zshrc -> `ln -s /home/shannon/git/.cfg/.zshrc /home/shannon/.zshrc`  
.tmux.conf -> `ln -s /home/shannon/git/.cfg/tmux.conf /home/shannon/tmux.conf`  

If you screw these up you can use the `unlink` command to remove the symlink. 

5. Set Zsh to default shell `chsh -s $(which zsh)` and install oh-my-zsh `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

### Todo ###
* Figure out how to incorporate your ST build
* Be smarter. 



