#!/usr/bin/env bash

wd=$(pwd)
nixos_dir="/etc/nixos"
local_repo="$HOME/code/nixpkgs"
system_repo="$nixos_dir/nixpkgs"
origin_url='https://github.com/auntieNeo/nixpkgs'
upstream_url='https://github.com/nixos/nixpkgs'

function git_checkout_local_temp {
  local prev_dir=$(pwd)

  local branch=$1
  local repo_path=$2

  # create a temporary directory
  local temp=$(mktemp -d --tmpdir=/tmp ${branch}.XXXXXXXXXX)
  echo "$temp"

  # clone the given repository with the given branch
  git clone --origin 'local' --branch $branch $repo_path $temp

  cd $prev_dir
}

function git_check_clean { 
}

# get the NixOS release string
if [ -f "$nixos_dir/release" ]; then
  release=$(cat "$nixos_dir/release")
else
  release="unstable"
fi

## fetch latest $(release) branch from GitHub origin
#cd $local_repo
#git fetch "origin"
#cd $wd
#
## attempt to merge the GitHub origin's $(release) branch into our local branch
#temp=$(git_checkout_local_temp "$release" "$local_repo")
#cd $temp
#echo $temp
#git remote add 'origin' "$origin_url"
#git fetch 'origin'
#git merge --ff-only "origin/$release"
#if $? != 0; then
#  echo "Could not fast-forward merge from origin/$release into local/$release"
#  echo "Please merge origin/$release into $release branch of"
#  echo "$local_repo and then push the changes manually."
#  rm -rf "$temp"
#  exit 1
#fi
#cd "$local_repo"
#
#rm -rf "$temp"
#cd $wd
#exit

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
