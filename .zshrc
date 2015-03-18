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
alias cabaldeps='cabal install --only-dependencies -j'
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

alias install="yaourt"
alias __reload_zsh='source ~/.zshrc'
alias __reflector=' sudo reflector --verbose -l 6 --sort rate --save /etc/pacman.d/mirrorlist'
alias __mount_shared='sudo mount -t vboxsf shared /media/sf_shared'
alias __mount_usb='sudo mount /dev/sdb /mnt/usb'

alias dim='light -U 10'
alias bright='light -A 10'
alias reboot="sudo systemctl reboot"
alias shutdown="sudo systemctl poweroff"
alias suspend="sudo systemctl suspend"
alias lock="slock"
#cdpath+=(~/projects/cicd)

function sshi () {
	ssh -A -i ~/.ssh/alhazen_rsa alhazen@$1
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
    puppetresources -p . -o $1 --hiera ./tests/hiera.yaml --facts-override tests/facts-global.yaml --pdbfile tests/facts.yaml  --ignoremodules java ${@:3}
}

# set dual monitors
function setresol () {
    xrandr  --output DisplayPort-2 --mode 1920x1080 -r 60
}
function dual () {
    xrandr --output DisplayPort-2 --mode 1920x1080 --rate 60 --primary --right-of LVDS --output LVDS --auto
}
function laptop () {
    --xrandr --output DisplayPort-2 --off --output LVDS --auto
    xrandr --output VGA-0 --off --output LVDS --auto
}

# set single monitor
function single () {
    #xrandr --output DisplayPort-2 --mode 1920x1080 --rate 60 --output LVDS --off
    xrandr --output VGA-0 --mode 1920x1080 --rate 60 --output LVDS --off
}

function cabal-recreate () {
    cabal clean
    cabal sandbox delete
    cabal sandbox init
    cabal configure
    cabal install --only-dependencies -j
    cabal build -j
}

alias sshi_puppetmaster_dev=' sshi 192.168.30.123'
alias sshi_puppetmaster_staging=' sshi 192.168.30.105'
alias sshi_puppetmaster_prod=' sshi puppet2.prd.srv.cirb.lan'
alias sshi_jenkinsmaster_staging=' sshi 192.168.30.118'
alias sshi_jenkinsmaster_prod=' sshi jenkins2.prd.srv.cirb.lan'
alias sshi_jenkinsslave_staging=' sshi 192.168.30.140'
alias sshi_jenkinsslave_prod=' sshi SVAPPCAVL248.prd.srv.cirb.lan'
source /etc/profile.d/autojump.zsh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
