shopt -s autocd

alias vim='nvim'
alias ls='ls --color=auto'
alias la='ls -lah'
alias du='du -h'
alias lfile="ls -lah *(.)"
alias ldir="ls -ladh (\.*|*)(/,@)"
alias df=" df -h"
alias ag="ag --color-line-number=2"

function sshi () {
	ssh -A -i ~/.ssh/alhazen_rsa alhazen@$1
}

function presources () {
    puppetresources -p . -o $1 --hiera ./tests/hiera.yaml --pdbfile tests/facts.yaml ${@:2}
}

export PS1='\w\[\033[01;38m\]$(__git_ps1)\[\033[00m\] → '

#. $(autojump-share)/autojump.bash
