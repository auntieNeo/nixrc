{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/server.nix
      ../profiles/laptop.nix
      ../profiles/development.nix
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

  # specify port to bind to for SSH reverse tunneling
  services.ssh-phone-home.bindPort = 2244;
}
