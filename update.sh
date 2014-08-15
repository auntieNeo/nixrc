#!/usr/bin/env bash

# get the NixOS release string
if [ -f /etc/nixos/release ]; then
  release=$(cat /etc/nixos/release)
else
  release="unstable"
fi

# find the latest commit that Hydra has built for the release we're following
commit=$(curl -sI http://nixos.org/channels/nixos-${release}/ | grep Location | perl -n -e'/([0-9a-f]{7})\/\s*$/ && print $1')

# TODO: clone the local nixpkgs repo with the $(release) branch to a staging directory

# TODO: attempt to merge upstream's latest commit into our local ${release} branch
  # TODO: fail with error pointing to staging directory if merge failed (likely)

# TODO: pull ${release} branch from staging back into local nixpkgs repository
  # TODO: fail with error (possible if local ${release} branch has changes; unlikely)

# TODO: pull ${release} branch from local nixpkgs repository into /etc/nixos/nixpkgs repository (should always be fast-forwarded)

# TODO: execute ./rebuild.sh
