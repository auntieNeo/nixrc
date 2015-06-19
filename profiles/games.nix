{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
#    bzflag
    dolphinEmuMaster
#    mupen64plus
#    nexuiz
    openra
    pcsx2
#    prboom  # TODO: fix this build
    sauerbraten
#    scorched3d

    # Game related tools
    qtsixa
    steam
  ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    pcsx2 = pkgs.callPackage_i686 ../pkgs/pcsx2/default.nix { };
    qtsixa = pkgs.callPackage ../pkgs/qtsixa/default.nix { };
  };
}
