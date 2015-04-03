{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.asterisk;

  asteriskConfigFile = mkOptionType {
    name = "Asterisk config file";
    check = val:
      # TODO: make sure name is a valid filename
      (isString val.name) && (isString val.text);
  };

  asteriskUser = "asterisk";

  varlibdir = "/var/lib/asterisk";
  spooldir = "/var/spool/asterisk";
  logdir = "/var/log/asterisk";

  # grep -Ro --no-filename -e '".*\.conf"' /tmp/asterisk-13.2.0/ | uniq | sed 's/^"\(.*\)\.conf"/\1/'
  confFiles = [
  ];

  asteriskEtc = pkgs.stdenv.mkDerivation
  ((mapAttrs' (name: value: nameValuePair
        ((replaceChars ["."] ["_"] name) + "_")
        (value)
      ) cfg.otherConfig) //
  {
    confFilesString = concatStringsSep " " (
      attrNames cfg.otherConfig
    );

    name = "asterisk.etc";

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

    modulesConf = cfg.modulesConfig;

    buildCommand = ''
      mkdir -p "$out"
      echo "$asteriskConf" | sed "s|@out@|$out|g" > "$out"/asterisk.conf
      echo "$extraConf" >> "$out"/asterisk.conf

      echo "$modulesConf" > "$out"/modules.conf

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

      modulesConfig = mkOption {
        default = ''
          [modules]
          autoload=yes
        '';
        type = types.lines;
        description = ''
          Configuration options in the modules.conf file.
        '';
      };

      extraConfig = mkOption {
        default = "";
        type = types.lines;
        example = ''
        '';
        description = ''
          Extra configuration options appended to the asterisk.conf file.
        '';
      };

      otherConfig = mkOption {
        default = {};
#        type = types.listOf asteriskConfigFile;  # FIXME
        example = {
          "musiconhold.conf" = ''
            [default]
            mode=files
            directory=/var/lib/asterisk/mohmp3
          '';
          "voicemail.conf" = ''
            [general]
            format=gsm|wav49|wav
            serveremail=asterisk
            attach=no
            mailcmd=/usr/sbin/sendmail -t
            maxmessage=180
            maxgreet=60

            [default]
            100 => 1234,Me,me@mydomain.com
          '';
        };
        description = ''
          Other config files in the Asterisk configuration directory.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    users.extraUsers = singleton
    { name = asteriskUser;
#      uid = config.ids.uids.asterisk;  # FIXME
      uid = 2000;
      description = "Asterisk daemon user";
      home = varlibdir;
    };

    systemd.services.asterisk = {
      description = ''
        Asterisk PBX server
      '';

      serviceConfig = {
      };

      preStart = ''
        # Copy skeleton directory tree to /var
        for d in '${varlibdir}' '${spooldir}' '${logdir}'; do
          rm -rf "$d" # FIXME: This is for debugging
          # TODO: Make exceptions for directories that should be overwritten
          if [ ! -e "$d" ]; then
            cp --recursive ${pkgs.asterisk}/"$d" "$d"
            chown --recursive ${asteriskUser} "$d"
            find "$d" -type d | xargs chmod 0755
          fi
        done
      '';

      script = ''
        ${pkgs.asterisk}/bin/asterisk -v -U ${asteriskUser} -C ${asteriskEtc}/asterisk.conf
      '';
    };
  };
}
