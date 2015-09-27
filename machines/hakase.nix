{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/android.nix
      ../profiles/audio.nix
      ../profiles/desktop.nix
      ../profiles/development.nix
      ../profiles/graphics.nix
      ../profiles/laptop.nix
      ../profiles/printing.nix
      ../profiles/redshift.nix
      ../profiles/server.nix
      ../profiles/telephony.nix
      ../profiles/virtualization.nix
#      ../profiles/games.nix

      # Experimental:
      ../profiles/mesa.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver = {
    # Disable RenderAccel for faster rendering in terminal emulators.
    deviceSection = ''
      Option "RenderAccel" "false"
    '';
  };

  # Specify port to bind to for SSH reverse tunneling
  services.ssh-phone-home = {
    enable = true;
    bindPort = 2244;
  };

#  networking.firewall.enable = false;
  networking.firewall.allowPing = true;

#  # Share ethernet connection
#  networking.nat = {
#    enable = true;
#    externalInterface = "wlp4s0";
#    internalIPs = [ "192.168.1.0/24" ];
#    internalInterfaces = [ "enp1s0" ];
#  };
#  networking.interfaces.enp1s0 = {
#    ipAddress = "192.168.0.1";
#    prefixLength = 24;
#  };
}
