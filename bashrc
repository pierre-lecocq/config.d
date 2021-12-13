arch=`uname`

# Env vars
export GOPATH=$HOME/src/go
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:$HOME/.local/bin:$HOME/bin:$HOME/.rvm/bin:$GOPATH/bin
export TERM=xterm-256color
export PAGER="less -F -X"
export EDITOR=emacs

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Don't put duplicate lines in the history.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and update LINES and COLUMNS.
shopt -s checkwinsize

# Enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Git completion
[ -f ~/.git-completion.bash ] || (curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash)
. ~/.git-completion.bash

# Prompt
git_current_branch() {
    br=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    [ -z "$br" ] || echo ":$br";
}

PS1="\e[1m[\A] \w\e[33m\$(git_current_branch)\e[0m\e[1m"
if [ $(id -u) -eq 0 ]; then
   PS1="$PS1 #\e[0m  "
else
   PS1="$PS1 \\$\e[0m  "
fi

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Aliases
if [ $arch = "Darwin" ]; then
    export HOMEBREW_NO_ANALYTICS=1
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
    alias l="/bin/ls -lh"
    alias la="/bin/ls -lhA"
    alias emacs='/usr/local/bin/emacs -nw "$@"'
    alias xemacs='/usr/local/bin/emacs "$@"'
    alias x='xemacs'
    alias x.='xemacs . &'
    alias xnotes='xemacs ~/src/_notes &'
elif [ $arch = "Linux" ]; then
    alias e='emacs'
    alias e.='emacs . &'
    alias l="ls -lh --color=auto"
    alias la="ls -lhA --color=auto"
fi

alias less='less -N'
alias grep='grep --color=auto'
alias rcl='find . -name "*~" -o -name ".*~" -o -name "._*" -o -name ".DS*" | xargs rm -f'
alias irb='irb --simple-prompt'
alias curl='curl --progress-bar'
alias tree='tree -C'
alias ipinfo='curl ipinfo.io'
alias fuckdocker='docker stop $(docker ps -a -q); docker rm $(docker ps -a -q); docker rmi -f $(docker images -q); docker volume rm -f $(docker volume ls -qf dangling=true); docker network prune -f'
alias sbclscript='sbcl --non-interactive --load "$@"' # http://stackoverflow.com/a/9056005
