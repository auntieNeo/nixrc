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
in

{
  ###### interface

  options = {
    services.display.displayManager.wayland.swc-launch = {
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


  ###### implementation

  config = mkIf cfg.enable
  (
  let
    # Find the libswc-based session in the list of sessions
    swcSessionPath =
    let
      sessions = config.services.display.displayManager.sessions;
    in
    if length sessions == 1 then
      let
        sessionPath = (splitString "." "services.display.sessions") ++
                      (splitString "." ((head sessions).type));
      in
        if (attrByPath (sessionPath ++ ["attr" "libswc"]) false config) then
          sessionPath
        else
          throw "The swc-launch display manager can only handle libswc-based sessions."
    else if length sessions > 1 then
      throw "The swc-launch display manager cannot manage multiple sessions."
    else null;
  in
  {
    # needs setuid in order to manage tty's
    security.setuidPrograms = [ "swc-launch" ];

    services.display.displayManager.wayland.swc-launch.preStart = "";

    services.display.displayManager.wayland.swc-launch.start =
    ''
      ${config.security.wrapperDir}/swc-launch \
      -t /dev/tty${toString config.services.display.tty} \
      -- ${(attrByPath swcSessionPath null config).command}
    '';

    systemd.services.display = {
      serviceConfig = {
        # run display manager as an ordinary user
        User = "${cfg.user}";
      };
      environment = {
        # FIXME: This doesn't work when the user hasn't explicitly set her uid.
        XDG_RUNTIME_DIR = "/run/user/${toString config.users.extraUsers.${cfg.user}.uid}";
      };
    };
  });
}
