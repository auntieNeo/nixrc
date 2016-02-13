{ config, pkgs, lib, ... }:

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
#    scorched3d  # TODO: fix this build
    tesseract 
#    tremulous  # TODO: fix this package

    # Game related tools
    qtsixa
    steam
  ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    pcsx2 = pkgs.callPackage_i686 ../pkgs/pcsx2/default.nix { };
    qtsixa = pkgs.callPackage ../pkgs/qtsixa/default.nix { };
#    steam = pkgs.callPackage ../pkgs/steam/chrootenv.nix { };
    tesseract = pkgs.callPackage ../pkgs/tesseract/default.nix { };
  };
}
