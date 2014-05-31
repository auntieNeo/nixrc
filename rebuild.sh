#!/run/current-system/sw/bin/bash

cd /etc/nixos/
sudo git pull local master
sudo nixos-rebuild switch
