#!/run/current-system/sw/bin/bash
if [ $# -eq 0 ]; then
  SRC=$HOME/code/nixrc
else
  SRC=$1
fi
sudo rsync --filter="protect /hardware-configuration.nix" \
           --filter="protect /hostname" \
           --filter="protect /private" \
           --filter="exclude,s .gitignore" \
           --filter="exclude,s /.git" \
           --filter="exclude .*.swp" \
           --filter="exclude Session.vim" \
           --delete --recursive \
           $SRC/ /etc/nixos/
sudo nixos-rebuild switch
