{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/server.nix
    ];

  # Auxiliary SSH ports
  networking.firewall.allowedTCPPortRanges = [ { from = 2200; to = 2222; } ];
  # Mosh shell ports
  networking.firewall.allowedUDPPortRanges = [ { from = 60000; to = 60999; } ];
}

