{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gqrx
    rtl-sdr
  ];

  services.udev.extraRules = "${builtins.readFile "${pkgs.rtl-sdr}/etc/udev/rules.d/99-rtl-sdr.rules"}";

  boot.blacklistedKernelModules = [
    "dvb_usb_rtl28xxu"  # Conflicts with gqrx and other sdr software
  ];
}
