#!/run/current-system/sw/bin/bash

# TODO: determine if using "stable" or "unstable" branch

# Git method:
# TODO: make sure /etc/nixos/nixpkgs exists
# TODO: if it does not exist, clone ~/code/nixpkgs there
# TODO: if it does exist, make sure it has ~/code/nixpkgs as "local" in remotes
# TODO: fetch from "local"
# TODO: checkout "stable" or "unstable" branch
# TODO: pull from "local"

# Git-archive method:
# TODO: tarball the "stable" or "unstable" branch with git-archive
# TODO: rsync the archive over /etc/nixos/nixpkgs

if [ $# -eq 0 ]; then
  SRC=$HOME/code/nixrc
else
  SRC=$1
fi
sudo rsync --filter="protect /hardware-configuration.nix" \
           --filter="protect /hostname" \
           --filter="protect /private" \
           --filter="exclude,s *.gitignore" \
           --filter="exclude,s *.gitmodules" \
           --filter="exclude,s *.git" \
           --filter="exclude .*.swp" \
           --filter="exclude Session.vim" \
           --delete --recursive \
           $SRC/ /etc/nixos/
sudo nixos-rebuild switch
