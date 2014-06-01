{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/laptop.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Disable RenderAccel for faster rendering in terminal emulators.
  services.xserver = {
    deviceSection = ''
      Option "RenderAccel" "false"
    '';
  };
}
