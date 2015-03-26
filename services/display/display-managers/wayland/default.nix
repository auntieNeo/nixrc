{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.display;
in
{
  imports = [
    ./swc-launch.nix
    ./weston-launch.nix
  ];

  options = {
    services.display.displayManager.wayland = {};
  };
  config = {};
}
