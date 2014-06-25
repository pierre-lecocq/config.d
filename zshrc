# Env vars
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:$HOME/.rvm/bin:~/bin
export EDITOR=emacs

# Completion
autoload -U compinit && compinit
setopt completealiases
zstyle ':completion:*' menu select

# Commands autocorrect
setopt correctall

# History
export HISTSIZE=2000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_space

# /etc = cd /etc
setopt autocd

# VCS
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:git*' formats "%s://%r/%b"
vcs_info_wrapper() {
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
        echo "${vcs_info_msg_0_}"
    fi
}

# Prompt
autoload -U colors && colors
export PS1="%B%n@%m%b %~ %B%#%b "
export RPS1=$"(vcs_info_wrapper) %B%T%b"

# Aliases (a.k.a evil)
arch=`uname`
if [ $arch = "Darwin" ]; then
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
    alias l="ls -lh"
    alias la="ls -lhA"
    alias xemacs='/Applications/Emacs.app/Contents/MacOS/Emacs -g 321x84+0+70 &'
    alias gnus='/Applications/Emacs.app/Contents/MacOS/Emacs -g 321x84+0+70 -f gnus &'
elif [ $arch = "Linux" ]; then
    alias l="ls -lh --color=auto"
    alias la="ls -lhA --color=auto"
    alias gnus='emacs -f gnus &'
fi
alias grep='grep --color=auto'
alias rcl='find . -name "*~" -exec rm -f {} \; ; find . -name ".*~" -exec rm -f {} \; ; find . -name "._*" -exec rm -f {} \; ; find . -name ".DS*" -exec rm -f {} \;'
alias etagsup='rm -f TAGS; find . -regex ".*\.\(c\|h\|rb\|php\)" -print | xargs etags -a'
alias en='emacs -nw'
alias enq='emacs -nw -Q'
alias irb='irb --simple-prompt'
