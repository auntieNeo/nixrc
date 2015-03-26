{ config, lib, pkgs, ... }:

let
in
{
  options = {
    services.display.xserver = {
      exportConfiguration = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to symlink the X server configuration under
          <filename>/etc/X11/xorg.conf</filename>.
        '';
      };

      enableTCP = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to allow the X server to accept TCP connections.
        '';
      };

      modules = mkOption {
        type = types.listOf types.path;
        default = [];
        example = literalExample "[ pkgs.xf86_input_wacom ]";
        description = "Packages to be added to the module search path of the X server.";
      };

      resolutions = mkOption {
        type = types.listOf types.attrs;
        default = [];
        example = [ { x = 1600; y = 1200; } { x = 1024; y = 786; } ];
        description = ''
          The screen resolutions for the X server.  The first element
          is the default resolution.  If this list is empty, the X
          server will automatically configure the resolution.
        '';
      };

      videoDrivers = mkOption {
        type = types.listOf types.str;
        # !!! We'd like "nv" here, but it segfaults the X server.
        default = [ "ati" "cirrus" "intel" "vesa" "vmware" "modesetting" ];
        example = [ "vesa" ];
        description = ''
          The names of the video drivers the configuration
          supports. They will be tried in order until one that
          supports your card is found.
        '';
      };

      drivers = mkOption {
        type = types.listOf types.attrs;
        internal = true;
        description = ''
          A list of attribute sets specifying drivers to be loaded by
          the X11 server.
        '';
      };

      vaapiDrivers = mkOption {
        type = types.listOf types.path;
        default = [ ];
        example = literalExample "[ pkgs.vaapiIntel pkgs.vaapiVdpau ]";
        description = ''
          Packages providing libva acceleration drivers.
        '';
      };

      startGnuPGAgent = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to start the GnuPG agent when you log in.  The GnuPG agent
          remembers private keys for you so that you don't have to type in
          passphrases every time you make an SSH connection or sign/encrypt
          data.  Use <command>ssh-add</command> to add a key to the agent.
        '';
      };

      # FIXME: move this out
      layout = mkOption {
        type = types.str;
        default = "us";
        description = ''
          Keyboard layout.
        '';
      };

      # FIXME: move this out
      xkbModel = mkOption {
        type = types.str;
        default = "pc104";
        example = "presario";
        description = ''
          Keyboard model.
        '';
      };

      # FIXME: move this out
      xkbOptions = mkOption {
        type = types.str;
        default = "terminate:ctrl_alt_bksp";
        example = "grp:caps_toggle, grp_led:scroll";
        description = ''
          X keyboard options; layout switching goes here.
        '';
      };

      # FIXME: move this out
      xkbVariant = mkOption {
        type = types.str;
        default = "";
        example = "colemak";
        description = ''
          X keyboard variant.
        '';
      };

      config = mkOption {
        type = types.lines;
        description = ''
          The contents of the configuration file of the X server
          (<filename>xorg.conf</filename>).
        '';
      };

      deviceSection = mkOption {
        type = types.lines;
        default = "";
        example = "VideoRAM 131072";
        description = "Contents of the first Device section of the X server configuration file.";
      };

      screenSection = mkOption {
        type = types.lines;
        default = "";
        example = ''
          Option "RandRRotation" "on"
        '';
        description = "Contents of the first Screen section of the X server configuration file.";
      };

      monitorSection = mkOption {
        type = types.lines;
        default = "";
        example = "HorizSync 28-49";
        description = "Contents of the first Monitor section of the X server configuration file.";
      };

      # FIXME: move out of here (maybe? Wayland should support XRandR)
      xrandrHeads = mkOption {
        default = [];
        example = [ "HDMI-0" "DVI-0" ];
        type = with types; listOf string;
        description = ''
          Simple multiple monitor configuration, just specify a list of XRandR
          outputs which will be mapped from left to right in the order of the
          list.

          Be careful using this option with multiple graphic adapters or with
          drivers that have poor support for XRandR, unexpected things might
          happen with those.
        '';
      };

      serverFlagsSection = mkOption {
        default = "";
        example =
          ''
          Option "BlankTime" "0"
          Option "StandbyTime" "0"
          Option "SuspendTime" "0"
          Option "OffTime" "0"
          '';
        description = "Contents of the ServerFlags section of the X server configuration file.";
      };

      moduleSection = mkOption {
        type = types.lines;
        default = "";
        example =
          ''
            SubSection "extmod"
            EndSubsection
          '';
        description = "Contents of the Module section of the X server configuration file.";
      };

      serverLayoutSection = mkOption {
        type = types.lines;
        default = "";
        example =
          ''
            Option "AIGLX" "true"
          '';
        description = "Contents of the ServerLayout section of the X server configuration file.";
      };

      extraDisplaySettings = mkOption {
        type = types.lines;
        default = "";
        example = "Virtual 2048 2048";
        description = "Lines to be added to every Display subsection of the Screen section.";
      };

      defaultDepth = mkOption {
        type = types.int;
        default = 0;
        example = 8;
        description = "Default colour depth.";
      };

      useXFS = mkOption {
        # FIXME: what's the type of this option?
        default = false;
        example = "unix/:7100";
        description = "Determines how to connect to the X Font Server.";
      };

      # FIXME: move out of here
      tty = mkOption {
        type = types.int;
        default = 7;
        description = "Virtual console for the X server.";
      };

      display = mkOption {
        type = types.int;
        default = 0;
        description = "Display number for the X server.";
      };

      # FIXME: move out of here (maybe? I'm not even sure why there's an option for this)
      virtualScreen = mkOption {
        type = types.nullOr types.attrs;
        default = null;
        example = { x = 2048; y = 2048; };
        description = ''
          Virtual screen size for Xrandr.
        '';
      };

      useGlamor = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to use the Glamor module for 2D acceleration,
          if possible.
        '';
      };
    };
  };
  # TODO: mkIf *we happen to be using X*
  config = {

    assertions =
      [ { assertion = !(config.programs.ssh.startAgent && cfg.startGnuPGAgent);
          message =
            ''
              The OpenSSH agent and GnuPG agent cannot be started both. Please
              choose between ‘programs.ssh.startAgent’ and ‘services.xserver.startGnuPGAgent’.
            '';
        }
        { assertion = config.security.polkit.enable;
          message = "X11 requires Polkit to be enabled (‘security.polkit.enable = true’).";
        }
        # TODO: write assertion to make sure services.xserver isn't enabled
      ];

    environment.etc =
      (optionals cfg.exportConfiguration
        [ { source = "${configFile}";
            target = "X11/xorg.conf";
          }
          # -xkbdir command line option does not seems to be passed to xkbcomp.
          { source = "${pkgs.xkeyboard_config}/etc/X11/xkb";
            target = "X11/xkb";
          }
        ]);

    environment.systemPackages =
      [ xorg.xorgserver
        xorg.xrandr
        xorg.xrdb
        xorg.setxkbmap
        xorg.iceauth # required for KDE applications (it's called by dcopserver)
        xorg.xlsclients
        xorg.xset
        xorg.xsetroot
        xorg.xinput
        xorg.xprop
        pkgs.xterm
        pkgs.xdg_utils
      ]
      ++ optional (elem "virtualbox" cfg.videoDrivers) xorg.xrefresh;

    environment.pathsToLink =
      [ "/etc/xdg" "/share/xdg" "/share/applications" "/share/icons" "/share/pixmaps" ];

    services.display.xserver = {

      videoDrivers = mkIf (cfg.videoDriver != null) [ cfg.videoDriver ];

      # FIXME: somehow check for unknown driver names.
      drivers = flip concatMap cfg.videoDrivers (name:
        let driver =
          attrByPath [name]
            (if xorg ? ${"xf86video" + name}
             then { modules = [xorg.${"xf86video" + name}]; }
             else null)
            knownVideoDrivers;
        in optional (driver != null) ({ inherit name; driverName = name; } // driver));

      config =
      ''
        Section "ServerFlags"
          Option "AllowMouseOpenFail" "on"
          ${cfg.serverFlagsSection}
        EndSection

        Section "Module"
          ${cfg.moduleSection}
        EndSection

        Section "Monitor"
          Identifier "Monitor[0]"
          ${cfg.monitorSection}
        EndSection

        Section "InputClass"
          Identifier "Keyboard catchall"
          MatchIsKeyboard "on"
          Option "XkbRules" "base"
          Option "XkbModel" "${cfg.xkbModel}"
          Option "XkbLayout" "${cfg.layout}"
          Option "XkbOptions" "${cfg.xkbOptions}"
          Option "XkbVariant" "${cfg.xkbVariant}"
        EndSection

        Section "ServerLayout"
          Identifier "Layout[all]"
          ${cfg.serverLayoutSection}
          # Reference the Screen sections for each driver.  This will
          # cause the X server to try each in turn.
          ${flip concatMapStrings cfg.drivers (d: ''
            Screen "Screen-${d.name}[0]"
          '')}
        EndSection

        ${if cfg.useGlamor then ''
          Section "Module"
            Load "dri2"
            Load "glamoregl"
          EndSection
        '' else ""}

        # For each supported driver, add a "Device" and "Screen"
        # section.
        ${flip concatMapStrings cfg.drivers (driver: ''

          Section "Device"
            Identifier "Device-${driver.name}[0]"
            Driver "${driver.driverName or driver.name}"
            ${if cfg.useGlamor then ''Option "AccelMethod" "glamor"'' else ""}
            ${cfg.deviceSection}
            ${xrandrDeviceSection}
          EndSection

          Section "Screen"
            Identifier "Screen-${driver.name}[0]"
            Device "Device-${driver.name}[0]"
            ${optionalString (cfg.monitorSection != "") ''
              Monitor "Monitor[0]"
            ''}

            ${cfg.screenSection}

            ${optionalString (cfg.defaultDepth != 0) ''
              DefaultDepth ${toString cfg.defaultDepth}
            ''}

            ${optionalString
                (driver.name != "virtualbox" &&
                 (cfg.resolutions != [] ||
                  cfg.extraDisplaySettings != "" ||
                  cfg.virtualScreen != null))
              (let
                f = depth:
                  ''
                    SubSection "Display"
                      Depth ${toString depth}
                      ${optionalString (cfg.resolutions != [])
                        "Modes ${concatMapStrings (res: ''"${toString res.x}x${toString res.y}"'') cfg.resolutions}"}
                      ${cfg.extraDisplaySettings}
                      ${optionalString (cfg.virtualScreen != null)
                        "Virtual ${toString cfg.virtualScreen.x} ${toString cfg.virtualScreen.y}"}
                    EndSubSection
                  '';
              in concatMapStrings f [8 16 24]
            )}

          EndSection
        '')}

        ${xrandrMonitorSections}
      '';
    };
  };
}
