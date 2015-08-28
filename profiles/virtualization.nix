{ config, pkgs, ... }:

{
  nixpkgs.config = {
    # Enable VirtualBox extensions (requires manual download)
    virtualbox.enableExtensionPack = true;
  };

  # Load VirtualBox kernel modules.
  # FIXME: This interferes with AziLink Android tethering because they both use 192.168.56.0/24
  virtualisation.virtualbox.host.enable = true;

  environment.systemPackages = with pkgs; [
#    gentoo
    kvm
    linuxPackages.virtualbox
    vagrant
  ];

  # custom packages
  nixpkgs.config.packageOverrides = pkgs: rec {
    gentoo = pkgs.callPackage ../pkgs/gentoo/default.nix { };
    gentoo-original = pkgs.callPackage ../pkgs/gentoo/default.nix { };
  };
}
