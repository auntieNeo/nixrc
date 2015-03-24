# This module declares the options common to both X11 and Wayland sessions.

{ config, lib, pkgs, ... }:

{
  imports = [
    ./wayland/default.nix
  ];

  options = {
    services.display.sessions = {
    };
  };

  config = {};
}
