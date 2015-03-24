# This module declares the options common to Wayland sessions.

{ config, lib, pkgs, ... }:

{
  imports = [
    ./velox/default.nix
  ];

  options = {
    services.display.sessions.wayland = {};
  };

  config = {};
}
