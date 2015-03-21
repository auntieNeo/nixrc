{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/development.nix
      ../profiles/server.nix
      ../profiles/virtualization.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/disk/by-id/wwn-0x50014ee0ad9ca4a8";

  services.xserver = {
    config = ''
      Section "Monitor"
        Identifier "DisplayPort-0"
        Option "Primary" "true"
        Option "PreferredMode" "1920x1080"
      EndSection

      Section "Monitor"
        Identifier "DVI-0"
        Option "PreferredMode" "1680x1050"
        Option "Rotate" "left"
        Option "RightOf" "DisplayPort-0"
      EndSection

      Section "Monitor"
        Identifier "DVI-1"
        Option "PreferredMode" "1680x1050"
        Option "Rotate" "left"
        Option "RightOf" "DVI-0"
      EndSection
    '';
  };

  # Specify port to bind to for SSH reverse tunneling
  services.ssh-phone-home = {
    enable = true;
    remoteHostname = pkgs.lib.mkForce "minerve.cose.isu.edu";
    bindPort = 2222;
    remoteUser = pkgs.lib.mkForce "glinjona";
  };
}
