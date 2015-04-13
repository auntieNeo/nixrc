{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/printing.nix
      ../profiles/desktop.nix
      ../profiles/development.nix
      ../profiles/laptop.nix
      ../profiles/server.nix
      ../profiles/telephony.nix
      ../profiles/virtualization.nix
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
}
