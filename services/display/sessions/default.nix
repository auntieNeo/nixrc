# This module declares the options common to both X11 and Wayland sessions.

{ config, lib, pkgs, ... }:

with lib;

#let
#  /*
#   * The following routines check the interfaces of self-declared "session"
#   * modules, effectively enforcing a "polymorphism" pattern for the module
#   * interfaces.
#   *
#   * Strictly speaking, this is not necessary. The duck-typing of the Nix
#   * language will resolve well-formed session modules, and *should* catch
#   * most bad ones. These are more like unit tests on the module interfaces,
#   * which document, test, and codify the "session" interface.
#   */
#  let
#    sessions = with config.services.display.sessions;
#                 ((builtins.attrNames wayland) ++
#                 (builtins.attrNames x11));
#  in
#    let
#      bar = null;
#    in
#      foo = null;
#  in
#    silly = null;
#
#in
{
  imports = [
    ./wayland/default.nix
  ];

  options = {
    services.display.sessions = {
    };
  };

  config = {
  };
}
