# The weston-launch "display manager" only supports launching Weston, the
# reference compositor for Wayland.
#
# As swc-launch does not provide an interface to input a username or password,
# this module behaves as the "auto" display manager; a defaultUser option must
# be provided.
#
# This module is only a dummy for as long as the "auto" display manager does not
# support launching Weston.
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.display.displayManager.wayland.weston-launch;
in

{
  options = {
    services.display.displayManager.wayland.weston-launch = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable starting Weston with weston-launch.
        '';
      };

      user = mkOption {
        type = types.str;
        default = null;
        description = "User to run weston-launch as.";
      };

      preStart = mkOption {
        type = types.lines;
        internal = true;
        default = "";
        description = "Display manager pre-start script.";
      };

      start = mkOption {
        type = types.lines;
        internal = true;
        default = null;
        description = "Display manager start script.";
      };
    };
  };

  config = mkIf cfg.enable {
    # needs setuid in order to manage tty's
    security.setuidPrograms = [ "weston-launch" ];

    services.display.displayManager.wayland.weston-launch = {
      preStart = "";

      start =
      ''
        ${config.security.wrapperDir}/weston-launch \
        -t /dev/tty${toString config.services.display.tty}
      '';
    };

    systemd.services.display = {
      serviceConfig = {
        # run display manager as an ordinary user
        User = "${cfg.user}";
      };
      environment = {
        # FIXME: This doesn't work when the user hasn't explicitly set her uid.
#        XDG_RUNTIME_DIR = "/run/user/${toString config.users.extraUsers.${cfg.user}.uid}";
      };
    };
  };
}
