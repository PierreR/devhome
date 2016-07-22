shopt -s autocd

alias vim='nvim'
alias ls='ls --color=auto'
alias la='ls -lah'
alias du='du -h'
alias lfile="ls -lah *(.)"
alias ldir="ls -ladh (\.*|*)(/,@)"
alias df=" df -h"
alias ag="ag --color-line-number=2"

export PS1='\u \w\[\033[01;38m\]$(__git_ps1)\[\033[00m\] → '
