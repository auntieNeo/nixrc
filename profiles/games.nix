{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openra
    sauerbraten
    steam
  ];
}
