#!/usr/bin/env bash

wd=$(pwd)
nixos_dir="/etc/nixos"
local_repo="$HOME/code/nixpkgs"
system_repo="$nixos_dir/nixpkgs"

function git_checkout_temp {
  local prev_dir=$(pwd)

  local branch=$1
  local repo_path=$2

  # create a temporary directory
  temp=$(sudo mktemp -d --tmpdir=/tmp ${branch}.XXXXXXXXXX)
  echo "created: $temp"

  cd $prev_dir
}

# get the NixOS release string
if [ -f "$nixos_dir/release" ]; then
  release=$(cat "$nixos_dir/release")
else
  release="unstable"
fi

# fetch latest $(release) branch from GitHub origin
cd $local_repo
git fetch "origin"
# TODO: attempt to merge the GitHub origin's $(release) branch into our local branch
git pull 
cd $wd

# find the latest commit that Hydra has built for the release we're following
commit=$(curl -sI http://nixos.org/channels/nixos-${release}/ | grep Location | perl -n -e'/([0-9a-f]{7})\/\s*$/ && print $1')


# TODO: check if the current local $(release) branch is already a descendant of that commit

# create a temporary staging directory
staging=$(sudo mktemp -d --tmpdir=/tmp nixpkgs_${release}_staging.XXXXXXXXXX)
echo "created: $staging"

# clone the local nixpkgs repo with the $(release) branch to the staging directory
sudo git clone --origin 'local' --branch $release $HOME/code/nixpkgs $staging

# TODO: attempt to merge upstream's latest commit into our local ${release} branch
cd $staging
sudo git 

# TODO: fail with error pointing to staging directory if merge failed (likely)

# TODO: pull ${release} branch from staging back into local nixpkgs repository
  # TODO: fail with error (possible if local ${release} branch has changes; unlikely)

# TODO: pull ${release} branch from local nixpkgs repository into /etc/nixos/nixpkgs repository (should always be fast-forwarded)

# TODO: execute ./rebuild.sh

# TODO: prompt to push to github origin repository

# clean up
#sudo rmdir $staging
