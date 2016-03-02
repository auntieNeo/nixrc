{ config, lib, pkgs, ... }:

{
  # install packages for Android development
  environment.systemPackages = with pkgs; [
#    androidndk
#    androidsdk
#    openvpn
  ];

  # FIXME: Can't seem to get adb to work without root
  services.udev.extraRules =
    ''
      SUBSYSTEM=="usb", ATTR(idVendor)=="18D1", MODE="0666" OWNER="auntieneo"
      SUBSYSTEM=="usb", ATTR(idVendor)=="22B8", MODE="0666" OWNER="auntieneo"
    '';
}
