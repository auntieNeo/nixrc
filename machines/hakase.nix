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

  services.xserver = {
    # Disable RenderAccel for faster rendering in terminal emulators.
    deviceSection = ''
      Option "RenderAccel" "false"
    '';

    # TODO: Get this TrackPoint configuration working.
#    # Enable vertical and horizontal TrackPoint scrolling.
#    inputDeviceSection = ''
#      Driver "TPPS/2 IBM TrackPoint"
#      Option "Evdev Wheel Emulation" "8 1"
#      Option "Evdev Wheel Emulation Button" "8 2"
#      Option "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 8 6 7 4 5
#      Option "Evdev Wheel Emulation Timeout" "8 200"
#    '';
  };
}
