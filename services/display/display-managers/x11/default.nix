{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.display;
in
{
  imports = [
  ];

  options = {
    services.display.displayManager.x11 = {
      enable = mkOption {
        type = types.bool;
        default = false;
        internal = true;
        description = ''
          Whether to enable the X server (internal option; depends on the
          display manager selected).
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    # augment the display service with X11 options
    # (since we happen to be using an X11-based display manager)
    # TODO: use the "attr" option to define appropriate overrides
#    system.services.display = {
#      environment =
#        {
#          XKB_BINDIR = "${xorg.xkbcomp}/bin"; # Needed for the Xkb extension.
#          XORG_DRI_DRIVER_PATH = "/run/opengl-driver/lib/dri"; # !!! Depends on the driver selected at runtime.
#          LD_LIBRARY_PATH = concatStringsSep ":" (
#            [ "${xorg.libX11}/lib" "${xorg.libXext}/lib" ]
#            ++ concatLists (catAttrs "libPath" cfg.drivers));
#        } // cfg.displayManager.job.environment;
#        preStart =
#          ''
#            ${cfg.displayManager.job.preStart}
#
#            rm -f /tmp/.X0-lock
#          '';
#    };
  };
}
