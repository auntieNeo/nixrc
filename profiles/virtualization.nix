{ config, pkgs, ... }:

{
  nixpkgs.config = {
    # Enable VirtualBox extensions (requires manual download)
    virtualbox.enableExtensionPack = true;
  };

  # Load VirtualBox kernel modules.
  services.virtualboxHost.enable = true;

  environment.systemPackages = with pkgs; [
    kvm
    linuxPackages.virtualbox
    vagrant
  ];
}
