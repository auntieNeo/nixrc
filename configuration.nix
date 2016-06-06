# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# This configuration file simply determines the hostname before importing most
# of the actual configuration from ./configuration-common.nix. This is done so
# that the same configuration files can be used with both conventionally
# installed NixOS (see nixos-install) and NixOS installed by Nixops.

{ config, pkgs, ... }:

# TODO: Determine the hostname from either UUID or MAC address... or, whatever Nixops does
let hostName = "${builtins.readFile ./hostname}";
in
rec {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix  # FIXME: what to do with this?
      # Configuration common to conventional and Nixops-provisioned computers
      ./configuration-common.nix
      # Import machine-specific configuration files.
      (./machines + "/${hostName}.nix")
    ];

  networking.hostName = "${hostName}";

  boot = {
    # Use more recent kernel for Intel HD Graphics 520 support
    kernelPackages = pkgs.linuxPackages_4_3;
  };
}
