# The swc-launch "display manager" only supports launching libswc-based Wayland
# compositors, akin to the weston-launch utility which can only watch the Weston
# compositor.
#
# As swc-launch does not provide an interface to input a username or password,
# this module behaves as the "auto" display manager; a defaultUser option must
# be provided.
#
# This module is only a dummy for as long as the "auto" display manager does not
# support libswc-based compositors. This module can be safely removed from the
# user-exposed configuration interface once the "auto" display manager is made
# support libswc-based compositors.
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.display.displayManager.wayland.swc-launch;

  libswc = (import ../../../../pkgs/libswc/default.nix);  # DELETEME
in

{
  imports = [
    ./swc-servers/default.nix
    ];

  ###### interface

  options = {
    services.swc-launch = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable a Wayland compositor launched with swc-launch.
        '';
      };

      user = mkOption {
        type = types.str;
        default = null;
        description = "User to run swc-launch as.";
      };
    };
  };


  ###### implementation

  config = mkIf cfg.enable {
    # needs setuid in order to manage tty's
    security.setuidPrograms = [ "swc-launch" ];

    systemd.services.display = {
      serviceConfig = {
        # run display manager as an ordinary user
        User = "${cfg.user}";
      };
      environment = {
        # FIXME: This doesn't work when the user hasn't explicitly set her uid.
        XDG_RUNTIME_DIR = "/run/user/${toString config.users.extraUsers.${cfg.user}.uid}";
      };
      script = ''
        ${config.security.wrapperDir}/swc-launch \
          -t /dev/tty${config.services.display.tty} \
          -- ${cfg.command}  # FIXME
      '';
    };
  };
}
