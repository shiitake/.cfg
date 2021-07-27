# enable colors and set prompt

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Load aliases and shortcuts
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# The following lines were added by compinstall

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/shannon/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd
bindkey -v
# End of lines configured by zsh-newuser-install

# Powerline stuff
if [ -d /home/shannon/.local/lib/python2.7/site-packages/powerline ]; then 
	powerline_location="/home/shannon/.local/lib/python2.7/site-packages/powerline"
elif [ -d /usr/share/powerline ]; then
	powerline_location="/usr/share/powerline"
else
	powerline_location=""
fi

#statements
if [ ! -z $powerline_location ]; then
  # powerline-daemon -q
  # POWERLINE_BASH_CONTINUATION=1
  # POWERLINE_BASH_SELECT=1
  # source $powerline_location/bindings/zsh/powerline.zsh
fi

# Alias stuff
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep -E "state|to\ full|percentage"'

# Adds nvm plugin
# [ -f "~/.zsh-nvm/zsh-nvm.plugin.zsh" ] && source ~/.zsh-nvm/zsh-nvm.plugin.zsh

# Add stuff to path
if [ -d "$HOME/git/.cfg/.config/statusbar" ] ; then 
    export PATH="$PATH:$HOME/git/.cfg/.config/statusbar"
fi
