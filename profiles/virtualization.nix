{ config, pkgs, ... }:

{
  nixpkgs.config = {
    # Enable VirtualBox extensions (requires manual download)
    virtualbox.enableExtensionPack = true;
  };

  # Load VirtualBox kernel modules.
  services.virtualboxHost.enable = true;

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
