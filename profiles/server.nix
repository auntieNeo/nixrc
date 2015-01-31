{ config, pkgs, ... }:

{
  imports =
    [
      ../services/ssh-phone-home.nix
    ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # The "SSH phone home" service for SSH reverse tunneling
  # Machines using this will need to enable it with this:
  # services.ssh-phone-home.enable = pkgs.lib.mkForce true;
  services.ssh-phone-home = {
    # NOTE: bindPort should be specified on a per-machine basis
    enable = false;
    localUser = "auntieneo";
    remoteHostname = "minerve.cose.isu.edu";
    remotePort = 22;
    remoteUser = "glinjona";
  };
}
