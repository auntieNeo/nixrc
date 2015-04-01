{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.asterisk;

  varlibdir = "/var/lib/asterisk";
  spooldir = "/var/spool/asterisk";
  logdir = "/var/log/asterisk";

  asterisk_conf = ''
    [directories](!)
    astetcdir => /etc/asterisk
    astmoddir => /usr/lib/asterisk/modules
    astvarlibdir => /var/lib/asterisk
    astdbdir => /var/lib/asterisk
    astkeydir => /var/lib/asterisk
    astdatadir => /var/lib/asterisk
    astagidir => /var/lib/asterisk/agi-bin
    astspooldir => /var/spool/asterisk
    astrundir => /var/run/asterisk
    astlogdir => /var/log/asterisk
    astsbindir => /usr/sbin
  '';
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

      sipConfig = mkOption {
        default = "";
        type = types.lines;
        example = ''
        '';
        description = ''
          The contents of the sip.conf file.
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
    };
  };

  config = mkIf cfg.enable {
    systemd.services.asterisk = {
      description = ''
        Asterisk PBX server
      '';

      preStart = ''
        for d in '${varlibdir}' '${spooldir}' '${logdir}'; do
          if [ ! -e "$d" ]; then
            cp -r ${pkgs.asterisk}/"$d" "$d"
          fi
        done
      '';

      script = with cfg; ''
        ${pkgs.asterisk}/bin/asterisk -v
      '';
    };
  };
}
