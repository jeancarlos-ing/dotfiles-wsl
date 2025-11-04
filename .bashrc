# My bash config.

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

# countodwm  
cdown () {
    N=$1
  while [[ $((--N)) -gt  0 ]]
    do
        echo "$N" |  figlet -c | lolcat &&  sleep 1
    done
}

# navigation
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

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

# adding flags
alias df='df -h'
alias free='free -m'
alias grep='grep --color=auto'

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'
alias tag='git tag'
alias newtag='git tag -a'

# termbin
alias tb="nc termbin.com 9999"

# starship
eval $(starship init bash)
