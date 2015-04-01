{ config, lib, pkgs, ... }:

with lib;

let
  inherit (pkgs) openssh;
  cfg = config.services.ssh-phone-home;
in

{

  ###### interface

  options = {
    services.ssh-phone-home = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable a "phone home" reverse SSH proxy.
        '';
      };

      localUser = mkOption {
        description = ''
          Local user to connect as (i.e. the user with password-less SSH keys).
        '';
      };

      remoteHostname = mkOption {
        description = ''
          The remote host to connect to. This should be the host outside of the
          firewall or NAT.
        '';
      };

      remotePort = mkOption {
        default = 22;
        description = ''
          The port on which to connect to the remote host via SSH protocol.
        '';
      };

      remoteUser = mkOption {
        description = ''
          The username to connect to the remote host as.
        '';
      };

      bindPort = mkOption {
        default = 2222;
        description = ''
          The port to bind and listen to on the remote host.
        '';
      };
    };
  };


  ###### implementation

  config = mkIf cfg.enable {
    systemd.services.ssh-phone-home =
    {
      description = ''
        Reverse SSH tunnel as a service
      '';

      bindsTo = [ "network.target" ];

      serviceConfig = with cfg; {
        User = cfg.localUser;
        RestartSec = 10;  # restart every 10 seconds on failure
        Restart = "on-failure";
      };
      script = with cfg;  ''
        ${openssh}/bin/ssh -NTC -o ServerAliveInterval=60 -o ExitOnForwardFailure=yes -R ${toString bindPort}:localhost:22 -l ${remoteUser} -p ${toString remotePort} ${remoteHostname}
      '';
    };
  };
}
