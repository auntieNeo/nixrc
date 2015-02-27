# This module declares the options common to both Wayland and X11 display
# managers. The feature that defines a display manager in this context is that
# it provisions and starts user sessions on a tty with logind (see
# systemd-logind.service(8), as well as the more practical overview on the wiki
# <http://www.freedesktop.org/wiki/Software/systemd/writing-display-managers/>).
#
# Display managers can conceivably use any display technology (X11, Wayland,
# framebuffer, Mir) to launch a user session that uses any other display
# technology. The multiplicity here may (for some display manager/session
# combinations) present a problem in which a display manager isn't equiped to
# launch a particular user session (e.g. a newer Wayland-only display manager
# attempting to launch an older X11-only session or vice versa). This
# multiplicity is dealt with by abstracting the interfaces that X11 and Wayland
# sessions need to expose.
#
#
# The structures in this module as well as the session module are designed with
# a number of goals in mind:
#
#   1) To present display managers with separate but consistent interfaces for
#      both X11 and Wayland (and any others we might support) user sessions.
#   2) To prevent users from configuring a display manager with a sesson type
#      that it cannot support.
#   3) To facilitate hacks so that a given display manager can support session
#      types that it does not support natively.
#   4) To keep X11 and Wayland specific code separate (especially hacks).
#
#
# The abstraction used to achieve these goals introduces a few changes to the
# configuration interface that will need to be documented for users as they
# transition to the new system:
#
# These options are (obviously) not in services.xserver, but rather in
# services.display (It might even be more appropriate to put these options in
# services.logind or services.login; I haven't decided yet).
#
# The displayManager module no longer distinguishes between a window manager
# and a desktop manager. These two things are integrated into a single process
# in Wayland, and thus have no place at the "session" level of abstraction. See
# the options in the services.display.sessions.x11 module if you want to specify
# multiple X11 window manager + desktop manager combinations.
#
#
# See the comments at the top of services/dispay/sessions/default.nix for a
# description of the session module's role.

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.display;
in
{
  options = {
    services.display.displayManager = {
      enabled_sessions = mkOption {
        type = types.listOf types.str;
        internal = true;
        default = [];
        description = ''
          The list of sessions that have been enabled.
        '';
      };

      session = mkOption {
        default = [];
        example = literalExample
          ''
            [ { name = "velox";
                type = "wayland.velox";
              }
            ]
          '';
        description = ''
          The list of sessions to be supported.
        '';
      };
    };
  };
  config = {
  };
}
