## Remind Me ##

The point of this readme is to remind myself what I need to do to get these dot files to work. 

It would be awesome if I would just remember this stuff but for now this will have to suffice. 

1. Create a git directory in your home directory
2. Clone this repository in that directory
3. Create the following symlinks to the appropriate files

.vim ->  `ln -s /home/shannon/git/.cfg/.vim /home/shannon/.vim`  
.vimrc -> `ln -s /home/shannon/git/.cfg/.vimrc /home/shannon/.vimrc`  
.bashrc -> `ln -s /home/shannon/git/.cfg/.bashrc /home/shannon/.bashrc`  
.zshrc -> `ln -s /home/shannon/git/.cfg/.zshrc /home/shannon/.zshrc`  
.tmux.conf -> `ln -s /home/shannon/git/.cfg/tmux.conf /home/shannon/tmux.conf`  

4. Be smarter. 

If you screw these up you can use the `unlink` command to remove the symlink. 
