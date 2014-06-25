{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #openra  # TODO: write a package for OpenRA
  ];
}
