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

    blender = lib.overrideDerivation pkgs.blender (attrs: rec {
        name = "blender-git";
        src = pkgs.fetchgit {
          url = file:///home/auntieneo/code/blender/blender;
          rev = "refs/heads/master";
          sha256 = "97ab28abbf229cd4a8fa8dd7ee716834a83f82a73909fde57e5999dd8bdd4c5a";
        };
    });
  };
}
