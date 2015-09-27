{ config, lib, pkgs, ... }:

{
  # install graphics-related packages
  environment.systemPackages = with pkgs; [
    blender
    gimp
    inkscape
#    image-sdf
  ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    image-sdf = pkgs.callPackage ../pkgs/image-sdf/default.nix { };
  };
}
