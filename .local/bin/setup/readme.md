## Remind Me ##

The point of this readme is to remind myself what I need to do to get these dot files to work. 

It would be awesome if I would just remember this stuff but for now this will have to suffice. 

## Linux Setup ##

1. From a fresh install, open a console (Ctrl-Alt-F2)
2. Login as the user you created when installing the os
3. Change to root: `su -`
4. Install curl: `apt install -y curl`
5. Run the start-here script: `curl -Lks https://raw.githubusercontent.com/shiitake/.cfg/linux/.local/bin/setup/go.sh | bash -s username`
6. Wait for everything to finish.
7. Once it has completed reboot and login: `sudo reboot`

### Notes ###
If you notice errors on your dot files that mention invalid characters it is probably an encoding problem with line endings. You may have to dos2unix on the file. 

Fix line-ending issues by running dos2unix on all the plaintext files
  `find ./.config -maxdepth 2 -type f -exec dos2unix {} \;`
  `find ./.local -maxdepth 2 -type f -exec dos2unix {} \;`


If there are tablet issues you might need to disable the touchscreen by installing xinput.

View devices:  `xinput`  
Disable device:  `xinput disable <device id>` 

### todo ###

1. Automate git ssh credentials
