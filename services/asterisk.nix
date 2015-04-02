{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.asterisk;

  asteriskUser = "asterisk";

  varlibdir = "/var/lib/asterisk";
  spooldir = "/var/spool/asterisk";
  logdir = "/var/log/asterisk";

  confFiles = [
    "acl"
    "ccss"
    "cdr"
    "cel"
    "extensions"
    "fetaures"
    "indications"
    "manager"
    "modules"
    "sip"
    "stasis"
    "udptl"
  ];

  asteriskEtc = pkgs.stdenv.mkDerivation {
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

    confFilesString = lib.concatStringsSep " " confFiles;

    extensionsConf = cfg.extensionsConfig;
    sipConf = cfg.sipConfig;

    buildCommand = ''
      mkdir -p "$out"
      echo "$asteriskConf" | sed "s|@out@|$out|g" > "$out"/asterisk.conf
      echo "$extraConf" >> "$out"/asterisk.conf

      for i in $confFilesString; do
        conf=$(eval echo "\$${i}Conf")
        echo "$conf" > "$out"/"$i".conf
      done
    '';
  };
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

      extensionsConfig = mkOption {
        default = "";
        type = types.lines;
        example = ''
        '';
        description = ''
          The contents of the extensions.conf file.
        '';
      };

      sipConfig = mkOption {
        default = "";
        type = types.lines;
        example = ''
        '';
        description = ''
          The contents of the sip.conf file.
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
