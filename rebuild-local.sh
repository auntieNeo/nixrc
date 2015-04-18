#!/usr/bin/env bash

# Find latest version in 
#commit=$(curl -sI http://nixos.org/channels/nixos-unstable/ | grep Location | perl -n -e'/([0-9a-f]{7})\/\s*$/ && print $1')

## Git method:
#if [ ! -d /etc/nixos/nixpkgs ]; then
#  sudo git clone --origin 'local' --branch $release $HOME/code/nixpkgs /etc/nixos/nixpkgs
#fi
#wd=$(pwd)
#cd /etc/nixos/nixpkgs
## TODO: make sure repo has ~/code/nixpkgs as "local" in remotes and a $release branch (for freshly installed systems)
#sudo git checkout $release
#sudo git pull 'local' $release

SRC=$HOME/code/nixrc
sudo rsync --filter="protect /hardware-configuration.nix" \
           --filter="protect /hostname" \
           --filter="protect /nixpkgs" \
           --filter="protect /private" \
           --filter="protect /release" \
           --filter="exclude,s *.gitignore" \
           --filter="exclude,s *.gitmodules" \
           --filter="exclude,s *.git" \
           --filter="exclude .*.swp" \
           --filter="exclude Session.vim" \
           --delete --recursive --perms \
           $SRC/ /etc/nixos/

if [ $# -eq 0 ]; then
  operation='switch'
else
  operation=$1
fi
cd $wd
sudo nixos-rebuild --keep-failed  -I nixos=/home/auntieneo/code/nixpkgs/nixos -I nixpkgs=/home/auntieneo/code/nixpkgs $operation
