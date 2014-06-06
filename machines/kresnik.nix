{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/server.nix
    ];


  environment.systemPackages = with pkgs; [
#    freerdp
  ];

  # TODO: configure a local squid transparent proxy server to go through the corporate proxy

  # Use the corporate proxy.
  nix.proxy = http://ongate.onsemi.com:80;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  services.xserver = {
    config = ''
      Section "Monitor"
        Identifier "DVI-0"
        Option "Primary" "true"
        Option "PreferredMode" "1600x1200"
      EndSection

      Section "Monitor"
        Identifier "DVI-1"
        Option "PreferredMode" "1600x1200"
        Option "Rotate" "left"
        Option "RightOf" "DVI-0"
      EndSection
    '';
  };
}
