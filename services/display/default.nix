{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.display;
  dm = config.services.display.displayManager.active;
in
{
  imports = [
    ./display-managers/default.nix
    ./sessions/default.nix
  ];

  options = {
    services.display = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable X11/Wayland sessions managed with logind.
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
        default = 9;
        description = "Virtual console to use for display.";
      };
    };
  };

  # In here:  ''
  #   - Determine what display manager *tech* is being used.
  #   - Incorperate that display-managers/default.nix set with the // operator
  #   - Determine what sessions are being used? Not needed. The display manager needs to figure that out.
  config = mkIf cfg.enable {
    # TODO: assertions for display manager *tech*

    # FIXME: enable the following line
#    systemd.defaultUnit = mkIf cfg.autorun "graphical.target";

    # systemd service for the display manager
    systemd.services.display = {
      enable = true;
      description = "Display Manager";
      after = [ "systemd-udev-settle.service" "local-fs.target" "acpid.service" ];
      restartIfChanged = false;

      environment = {
        XKB_DEFAULT_LAYOUT = "${cfg.layout}";
        XKB_DEFAULT_OPTIONS = "${cfg.xkbOptions}";
      };  # // ${cfg.displayManager.${dm.tech}.attr.systemd};

      preStart =
        ''
          ${cfg.displayManager.${dm.tech}.${dm.name}.preStart}
        '';

      script = "${cfg.displayManager.${dm.tech}.${dm.name}.start}";
    };
  };
}
