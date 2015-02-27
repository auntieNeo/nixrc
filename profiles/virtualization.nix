{ config, pkgs, ... }:

{
  nixpkgs.config = {
    # Enable VirtualBox extensions (requires manual download)
    virtualbox.enableExtensionPack = true;
  };

  environment.systemPackages = with pkgs; [
    kvm
    linuxPackages.virtualbox
  ];
}
