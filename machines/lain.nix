{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/server.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/disk/by-id/wwn-0x50014ee0ad9ca4a8";

  services.xserver = {
    # Device-ati[0]
    deviceSection = ''
      Option "Monitor[0]" "DisplayPort-0"
      Option "Monitor[1]" "DVI-0"
      Option "Monitor[2]" "DVI-1"
    '';

    # Actually Monitor[0]
    monitorSection = ''
    '';

    config = ''
      Section "Monitor"
        Identifier "Monitor[1]"
        Option "Rotate" "left"
        Option "RightOf" "DisplayPort-0"
      EndSection

      Section "Monitor"
        Identifier "Monitor[2]"
        Option "Rotate" "left"
        Option "RightOf" "DVI-0"
      EndSection

      Section "Screen"
        Identifier "Screen-ati[1]"
        Device "Device-ati[0]"
        Monitor "Monitor[1]"
      EndSection

      Section "Screen"
        Identifier "Screen-ati[2]"
        Device "Device-ati[0]"
        Monitor "Monitor[2]"
      EndSection
    '';
  };
}
