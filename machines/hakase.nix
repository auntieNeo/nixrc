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

    # Enable vertical and horizontal TrackPoint scrolling.
    config = ''
      Section "InputClass"
        Identifier "Trackpoint Wheel Emulation"
        MatchProduct "TPPS/2 IBM TrackPoint|DualPoint Stick|Synaptics Inc. Composite TouchPad / TrackPoint|ThinkPad USB Keyboard with TrackPoint|USB Trackpoint pointing device|Composite TouchPad / TrackPoint"
        MatchDevicePath "/dev/input/event*"
        Option "EmulateWheel" "true"
        Option "EmulateWheelButton" "2"
        Option "XAxisMapping" "6 7"
        Option "YAxisMapping" "4 5"
      EndSection
    '';
  };
}
