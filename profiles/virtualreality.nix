{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
#    osvr-core
#    osvr-tracker-viewer
  ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    osvr-core = pkgs.callPackage ../pkgs/osvr-core/default.nix {};
    osvr-libfunctionality = pkgs.callPackage ../pkgs/osvr-libfunctionality/default.nix {};
    osvr-tracker-viewer = pkgs.callPackage ../pkgs/osvr-tracker-viewer/default.nix {};
    jsoncpp = lib.overrideDerivation pkgs.jsoncpp (attrs: rec {
      cmakeFlags = [
        "-DJSONCPP_WITH_CMAKE_PACKAGE=1"
        "-DCMAKE_CXX_FLAGS=-fPIC"
      ];
    });
  };
}
