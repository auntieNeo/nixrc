{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../services/ssh-phone-home.nix
    ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Allow remote hosts to connect to reverse proxy tunnels
  services.openssh.gatewayPorts = "clientspecified";

  # The "SSH phone home" service for SSH reverse tunneling
  # Machines that use this will still need to enable it with:
  # services.ssh-phone-home.enable = true;
  #
  # Machines that use settings other than this (e.g. a different
  # remoteHostname) should use lib.mkForce:
  # services.ssh-phone-home.remoteHostname = lib.mkForce "example.net";
  services.ssh-phone-home = {
    # NOTE: bindPort should be specified on a per-machine basis
    localUser = "auntieneo";
    remoteHostname = "auntieneo.net";
    remotePort = 22;
    remoteUser = "auntieneo";
  };
}
