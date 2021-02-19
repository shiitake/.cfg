# The following lines were added by compinstall

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/shannon/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd
bindkey -v
# End of lines configured by zsh-newuser-install

# Powerline stuff
. /home/shannon/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# Alias stuff
alias ls='ls --color=auto -oAF --no-group --group-directories-first'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'

alias wflist='iwlist wlp2s0 scan | grep -e "ESSID"'
alias wifi='nmcli device wifi connect Computer\!\!1 password ilikeyourdog'
alias hib='systemctl hibernate'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep -E "state|to\ full|percentage"'

# Adds nvm plugin
source ~/.zsh-nvm/zsh-nvm.plugin.zsh
