{ config, lib, pkgs, ... }:

{
  hardware.sane = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    saneFrontends
    xsane
  ];
}
