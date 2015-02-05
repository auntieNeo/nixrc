{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.swc-launch;

  libswc = (import ../../pkgs/libswc/default.nix);
in

{
  imports = [
    ./swc-servers/default.nix
    ];

  ###### interface

  options = {
    # TODO: Since there is no login screen (yet), add option to specify login user.
    services.swc-launch = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable a Wayland compositor launched with swc-launch.
        '';
      };

      layout = mkOption {
        type = types.str;
        default = "us";
        description = ''
          Keyboard layout.
        '';
      };

      xkbOptions = mkOption {
        type = types.str;
        default = "";
        example = "grp:caps_toggle, grp_led:scroll";
        description = ''
          xkb keyboard options.
        '';
      };

      tty = mkOption {
        type = types.int;
        default = 6;
        description = "Virtual console for swc-launch to use.";
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

    systemd.services.swc-launch = {
      description = "Launcher for libswc-based Wayland compositors";
      after = [ "systemd-udev-settle.service" "local-fs.target" "acpid.service" ];

      restartIfChanged = false;

      serviceConfig = {
        User = "${cfg.user}";
        LimitCORE = "infinity";
      };

      environment = {
        XKB_DEFAULT_LAYOUT = "${cfg.layout}";
        XKB_DEFAULT_OPTIONS = "${cfg.xkbOptions}";
      };

      preStart =
        ''
        '';

      script = with cfg; "${config.security.wrapperDir}/swc-launch -t /dev/tty${toString tty} -- ${server.${server.active_server}.command}";
    };
  };
}
