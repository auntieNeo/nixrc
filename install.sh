#!/run/current-system/sw/bin/bash

#
# This script automates configuration and installation of NixOS. It is intended
# to be run from the within the NixOS live boot medium. Filesystems creation
# and network configuration must be done beforehand.  followed by running
# 'nixos-generate-config --root /mnt' (see the NixOS manual).
#

PREFIX="/run/current-system/sw"

BASH="$PREFIX/bin/bash"
ECHO="$PREFIX/bin/echo"
GIT="$PREFIX/bin/git"
GREP="$PREFIX/bin/grep"
NIX_ENV="$PREFIX/bin/nix-env"
NIXOS_INSTALL="$PREFIX/bin/nixos-install"
REBOOT="$PREFIX/sbin/reboot"
RM="$PREFIX/bin/rm"
RSYNC="$PREFIX/bin/rsync"

HOSTNAME_FILE="/mnt/etc/nixos/hostname"
NIXRC="/mnt/nixrc"
NIXOS_CONFIG="/mnt/etc/nixos"
UUID_FILE="/sys/class/dmi/id/product_uuid"

# Check for files created by nixos-generate-config first.
if [ ! -d $NIXOS_CONFIG ]; then
  $ECHO "Error: Could not find /mnt/etc/nixos."
  $ECHO "Run 'nixos-generate-config --root /mnt' and review output first."
  exit 1
fi

# Clone the git repository containing the NixOS configuration.
if [ ! -d $NIXRC ]; then
  $NIX_ENV --install git
  cd /mnt/
  $GIT clone "https://github.com/auntieNeo/nixrc"
fi

# Determine the hostname from either UUID or MAC address.
if $GREP --quiet "01572D33-7B50-CB11-A0BB-8DFA84B41F9C" $UUID_FILE; then
  $ECHO -n "hakase" > $HOSTNAME_FILE
elif $GREP --quiet "00:25:22:cb:23:c1" "/sys/class/net/enp3s0/address"; then
  $ECHO -n "hazuki" > $HOSTNAME_FILE
else
  $ECHO -n "nixos" > $HOSTNAME_FILE
fi

# Rsync files from 
$RSYNC --filter="protect /hardware-configuration.nix" \
           --filter="protect /hostname" \
           --filter="exclude,s .gitignore" \
           --filter="exclude,s /.git" \
           --filter="exclude .*.swp" \
           --filter="exclude Session.vim" \
           --delete --recursive \
           $SRC/ $NIXOS_CONFIG/
$NIXOS_INSTALL && $RM -rf /mnt/nixrc && $REBOOT
