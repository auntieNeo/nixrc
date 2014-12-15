{ config, pkgs, ... }:

{
  imports =
    [
      ../services/ssh-phone-home.nix
    ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable the "SSH phone home" service for SSH reverse tunneling
  services.ssh-phone-home = {
    # NOTE: bindPort should be specified on a per-machine basis
    enable = true;
    localUser = "auntieneo";
    remoteHostname = "minerve.cose.isu.edu";
    remotePort = 22;
    remoteUser = "glinjona";
  };
}
