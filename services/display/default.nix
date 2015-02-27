{ config, lib, pkgs, ... }:

let
  cfg = config.services.display;
in
{
  options = {
    services.display = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable X11/Wayland sessions managed with logind.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    # TODO: create a systemd service for the display manager
    # TODO: figure out if anything special needs to be done for X11 vs Wayland display managers
    systemd.services.display-manager = {
      description = "Display Manager";
      after = [ "systemd-udev-settle.service" "local-fs.target" "acpid.service" ];
      restartIfChanged = false;
      environment = {
      };
    };
  };
}
