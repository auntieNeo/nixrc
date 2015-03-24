{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.display.displayManager;
in
{
  options = {
    services.display.displayManager.auto = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable the automatic login display manager.
        '';
      };

      user = mkOption {
        type = types.str;
        default = null;
        description = "User automatically log in as.";
      };
    };
  };
  config = mkIf cfg.enable {
  };
}
