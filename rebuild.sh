#!/run/current-system/sw/bin/bash

if [ -f /etc/nixos/release ]; then
  release=$(cat /etc/nixos/release)
else
  release="unstable"
fi


# TODO: check if repo is up to date
#commit=$(curl -sI http://nixos.org/channels/nixos-${release}/ | grep Location | perl -n -e'/([0-9a-f]{7})\/\s*$/ && print $1')
#
#echo $commit

# Git method:
if [ ! -d /etc/nixos/nixpkgs ]; then
  sudo git clone --origin 'local' --branch $release $HOME/code/nixpkgs /etc/nixos/nixpkgs
fi
wd=$(pwd)
cd /etc/nixos/nixpkgs
# TODO: make sure repo has ~/code/nixpkgs as "local" in remotes and a $release branch (for freshly installed systems)
sudo git checkout $release
sudo git pull 'local' $release

# Git-archive method:
# git archive --remote=file://$HOME/code/nixpkgs
# TODO: tarball the "stable" or "unstable" branch with git-archive
# TODO: rsync the archive over /etc/nixos/nixpkgs

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
sudo nixos-rebuild -I nixos=/etc/nixos/nixpkgs/nixos -I nixpkgs=/etc/nixos/nixpkgs $operation
