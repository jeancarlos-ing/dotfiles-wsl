# My personal config

# Export
export TERM="xterm-256color"
export HISTCONTROL=ignoredups:erasedups
export EDITOR="vim"
export MANPAGER="less"

# set vi mode
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return



# path
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "/opt/nvim/bin/" ];
  then PATH="/opt/nvim/bin/:$PATH"
fi

if [ -d "$HOME/go/bin/" ];
  then PATH="$HOME/go/bin/:$PATH"
fi

# settings other environment variables
if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi

# shopt
shopt -s autocd
shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob
shopt -s histappend
shopt -s expand_aliases
shopt -s checkwinsize

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# Changing "cat" to "bat"
alias cat="batcat"

# Changing "ls" to "eza"
alias ls='eza --icons -al --color=always --group-directories-first'
alias la='eza --icons -a --color=always --group-directories-first'
alias ll='eza --icons -l --color=always --group-directories-first'
alias lt='eza --icons -aT --color=always --group-directories-first'
alias l.='eza --icons -al --color=always --group-directories-first ../'
alias l..='eza --icons -al --color=always --group-directories-first ../../'
alias l...='eza --icons -al --color=always --group-directories-first ../../../'

# starship
eval $(starship init bash)
