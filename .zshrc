# setup a nice prompt
source ~/.zsh_prompt
# autoload -U colors && colors
autoload -U compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install

HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
setopt histignoredups
setopt histignorealldups
setopt hist_ignore_space
setopt autocd
setopt histverify
bindkey -e
# Use gvim exclusively
# alias vim='gvim --remote-silent'
# alias vim='vim --servername VIM'
alias xclip='xclip -selection c'
alias salt='sudo salt'
alias view='vim -R'
alias ls='ls --color=auto'
alias la='ls -lah'
alias du='du -h'
alias lfile="ls -lah *(.)"
alias ldir="ls -ladh (\.*|*)(/,@)"
alias df=" df -h"
alias ag="ag --color-line-number=2"
#alias hoogle="hoogle --color"

alias __reload_zsh='source ~/.zshrc'
alias __reflector=' sudo reflector --verbose -l 6 --sort rate --save /etc/pacman.d/mirrorlist'
alias __mount_shared='sudo mount -t vboxsf shared /media/sf_shared'
alias __mount_usb='sudo mount /dev/sdb /mnt/usb'

#cdpath+=(~/projects/cicd)

function sshi () {
	ssh -i ~/.ssh/alhazen_rsa alhazen@$1
}

function ssrc () {
	git rev-list --all | GIT_PAGER=less xargs git grep $1
}

function docker_ssh () {
	ssh -p $1 root@localhost
}

function swift_pra () {
    swift -A https://s.irisnet.be/auth/v1.0 -U techops:pradermecker -K c221930ce937c9d upload pra $1
}

function presources () {
    puppetresources -p . -o $1 --hiera ./tests/hiera.yaml --facts-override tests/facts-${2}.yaml --pdbfile tests/facts.yaml  -v ERROR --ignoremodules java ${@:3}
}

alias sshi_puppetmaster_dev=' sshi 192.168.30.123'
alias sshi_puppetmaster_staging=' sshi 192.168.30.105'
alias sshi_jenkinsmaster_staging=' sshi 192.168.30.118'
alias sshi_jenkinsmaster_prod=' sshi jenkins2.prd.srv.cirb.lan'
alias sshi_jenkinsslave_staging=' sshi 192.168.30.140'
source /etc/profile.d/autojump.zsh
