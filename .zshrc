# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/pi3r/.zshrc'
zstyle ':completion:*:options' description 'yes'

autoload -Uz compinit
# setup a nice prompt
source ~/.zsh_prompt
# autoload -U colors && colors
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install

# export JDK_HOME=/opt/java
# export JAVA_HOME=~/build/jdk1.6.0_26
# export BMOB_DIR=~/projects/bmob
# export MOZILLA_CERTIFICATE_FOLDER=~/.mozilla/firefox/djt0wc2v.default
# export DJANGO_SETTINGS_MODULE='settings'

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt histignoredups
setopt histignorealldups
setopt autocd
setopt histverify
bindkey -e
# Use gvim exclusively
# alias vim='gvim --remote-silent'
# alias vim='vim --servername VIM'
alias salt='sudo salt'
alias vi='gvim --remote-silent'
alias view='vim -R'
alias ls='ls --color=auto'
alias la='ls -lah'
alias du='du -h'
alias lfile="ls -lah *(.)"
alias ldir="ls -ladh (\.*|*)(/,@)"
alias df="df -h"

alias __reload_zsh='source ~/.zshrc'
alias __mount_shared='sudo mount.vmhgfs .host:/ /mnt/hgfs'
alias __mount_usb='sudo mount /dev/sdb /mnt/usb'
# alias close_laptop='xrandr --output LVDS1 --off --output VGA1 --auto'
# alias open_laptop='xrandr --output LVDS1 --auto --output VGA1 --auto --right-of LVDS1'
# alias ssh_bmob='ssh 192.168.34.51'
# alias __connect_to_staging='cd_django;ssh -i private_key pmobilite@192.168.15.66'
# alias __change_title='printf \\\\033]0\\;\\%s\\\\007 "$1"'
# alias __etags="cd_django;find . -type f -iname '*.py' | etags.emacs --lang=python -"
# alias __lock_pc="xscreensaver-command -lock"
# cdpath+=(~/projects/)

