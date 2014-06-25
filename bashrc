# Env vars
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:~/bin:~/.rvm/bin
export EDITOR=emacs

# Function - set term title
function termtitle {
    if [ -z $1 ]; then
        title=`hostname`
    else
        title=$1
    fi
    echo -n -e "\033]0;"$title"\007"
}

# Prompt
if [ $(id -u) -eq 0 ];
then
    PS1="\e[0;31m[\A] \u@\h \w # \e[m"
else
    PS1="[\A] \e[0;34m\u@\h\e[0m \w $ "
fi

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
alias modified='find . | while read FILE;do ls -dl "$FILE";done | grep `date +"%b"` | grep `date +"%_d"`'
alias etagsup='rm -f TAGS; find . -regex ".*\.\(c\|h\|rb\|php\)" -print | xargs etags -a'
alias en='emacs -nw'
alias enq='emacs -nw -Q'
alias irb='irb --simple-prompt'
