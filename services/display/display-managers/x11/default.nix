{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.display;
in
{
  imports = [
  ];

  options = {
    services.display.displayManager.x11 = {};
  };
  config = {};
}
