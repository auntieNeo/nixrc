{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.asterisk;

  asteriskUser = "asterisk";

  varlibdir = "/var/lib/asterisk";
  spooldir = "/var/spool/asterisk";
  logdir = "/var/log/asterisk";

  asteriskEtc = pkgs.stdenv.mkDerivation
  ((mapAttrs' (name: value: nameValuePair
        # Fudge the names to make bash happy
        ((replaceChars ["."] ["_"] name) + "_")
        (value)
      ) cfg.confFiles) //
  {
    confFilesString = concatStringsSep " " (
      attrNames cfg.confFiles
    );

    name = "asterisk.etc";

    # Default asterisk.conf file
    # (Notice that astetcdir will be set to the path of this derivation)
    asteriskConf = ''
      [directories]
      astetcdir => @out@
      astmoddir => ${pkgs.asterisk}/lib/asterisk/modules
      astvarlibdir => /var/lib/asterisk
      astdbdir => /var/lib/asterisk
      astkeydir => /var/lib/asterisk
      astdatadir => /var/lib/asterisk
      astagidir => /var/lib/asterisk/agi-bin
      astspooldir => /var/spool/asterisk
      astrundir => /var/run/asterisk
      astlogdir => /var/log/asterisk
      astsbindir => ${pkgs.asterisk}/sbin
    '';
    extraConf = cfg.extraConfig;

    # Loading all modules by default is considered sensible by the authors of
    # "Asterisk: The Definitive Guide". Secure sites will likely want to
    # specify their own "modules.conf" in the confFiles option.
    modulesConf = ''
      [modules]
      autoload=yes
    '';

    # Use syslog for logging so logs can be viewed with journalctl
    loggerConf = ''
      [general]

      [logfiles]
      syslog.local0 => notice,warning,error
    '';

    buildCommand = ''
      mkdir -p "$out"

      # Create asterisk.conf, pointing astetcdir to the path of this derivation
      echo "$asteriskConf" | sed "s|@out@|$out|g" > "$out"/asterisk.conf
      echo "$extraConf" >> "$out"/asterisk.conf

      echo "$modulesConf" > "$out"/modules.conf

      echo "$loggerConf" > "$out"/logger.conf

      # Config files specified in confFiles option override all other files
      for i in $confFilesString; do
        conf=$(echo "$i"_ | sed 's/\./_/g')
        echo "''${!conf}" > "$out"/"$i"
      done
    '';
  });
in

{
  options = {
    services.asterisk = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable Asterisk PBX server.
        '';
      };

      extraConfig = mkOption {
        default = "";
        type = types.lines;
        example = ''
          [options]
          verbose=3
          debug=3
        '';
        description = ''
          Extra configuration options appended to the default asterisk.conf
          file.

          If you would like to completely overwrite the asterisk.conf file (not
          recommended), see the confFiles option.
        '';
      };

      confFiles = mkOption {
        default = {};
        type = types.attrsOf types.str;
        example = {
          "extensions.conf" = ''
            [tests]
            exten => 100,1,Answer()
            same  =>     n,Wait(1)
            same  =>     n,Playback(hello-world)
            same  =>     n,Hangup()

            [softphones]
            include => tests

            [unauthorized]
          '';
          "sip.conf" = ''
            [general]
            allowguest=no              ; Require authentication
            context=unauthorized       ; Send unauthorized users to /dev/null
            srvlookup=no               ; Don't do DNS lookup
            udpbindaddr=0.0.0.0        ; Listen on all interfaces
            nat=force_rport,comedia    ; Assume device is behind NAT

            [softphone](!)
            type=friend                ; Match on username first, IP second
            context=softphones         ; Send to softphones context in
                                       ; extensions.conf file
            host=dynamic               ; Device will register with asterisk
            disallow=all               ; Manually specify codecs to allow
            allow=g722
            allow=ulaw
            allow=alaw

            [myphone](softphone)
            secret=GhoshevFew          ; Change this password!
          '';
          "logger.conf" = ''
            [general]

            [logfiles]
            ; Add debug output to log
            syslog.local0 => notice,warning,error,debug
          '';
        };
        description = ''
          Sets the content of config files (typically ending with .conf) in the
          Asterisk configuration directory.

          For a sample of what is possible here, see the sample configuration
          files included with Asterisk:

          ls $(nix-build --no-link -A asterisk '<nixpkgs>')/etc/asterisk/

          Note that if you want to change asterisk.conf, it is preferable to
          use the extraConfig option over this option. If "asterisk.conf" is
          specified with the confFiles option, you must be prepared to set your
          own astetcdir path.
        '';
      };

      extraArguments = mkOption {
        default = [];
        type = types.listOf types.str;
        example =
          [ "-vvvddd" "-e" "1024" ];
        description = ''
          Additional command line arguments to pass to Asterisk.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    users.extraUsers = singleton
    { name = asteriskUser;
#      uid = config.ids.uids.asterisk;
      uid = 2000;  # FIXME
      description = "Asterisk daemon user";
      home = varlibdir;
    };

    systemd.services.asterisk = {
      description = ''
        Asterisk PBX server
      '';

      wantedBy = [ "multi-user.target" ];

      preStart = ''
        # Copy skeleton directory tree to /var
        for d in '${varlibdir}' '${spooldir}' '${logdir}'; do
          # TODO: Make exceptions for /var directories that likely should be updated
          if [ ! -e "$d" ]; then
            cp --recursive ${pkgs.asterisk}/"$d" "$d"
            chown --recursive ${asteriskUser} "$d"
            find "$d" -type d | xargs chmod 0755
          fi
        done
      '';

      serviceConfig = {
        ExecStart =
          let
            # FIXME: This doesn't account for arguments with spaces
            argString = concatStringsSep " " cfg.extraArguments;
          in
          "${pkgs.asterisk}/bin/asterisk -U ${asteriskUser} -C ${asteriskEtc}/asterisk.conf ${argString} -F";
        Type = "forking";
        PIDFile = "/var/run/asterisk/asterisk.pid";
      };
    };
  };
}
