alias lfile="ls -lah *(.)"
alias ldir="ls -ladh (\.*|*)(/,@)"
alias dockerclean="docker rm $(docker ps -a -q)"
alias make='nocorrect make'
alias stack='nocorrect stack'

alias __mount_notebook='sudo mount -t vboxsf notebook /media/sf_notebook'
alias __mount_shared='sudo mount -t vboxsf shared /media/sf_shared'
alias __mount_usb='sudo mount /dev/sdb /mnt/usb'