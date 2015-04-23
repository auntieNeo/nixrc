{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
#    piglit
    piglit-patched
  ];
  nixpkgs.config.packageOverrides = pkgs:
    (let
    in
    rec {
#    xorg = pkgs.xorg // {
#      xorgserver = (lib.overrideDerivation pkgs.xorg.xorgserver (attrs: rec {
#        name = "xorgserver-${version}";
#        version = "1.17.1";
#
#        src = pkgs.fetchurl {
#          url = "http://www.x.org/releases/individual/xserver/xorg-server-${version}.tar.gz";
#          sha256 = "0zhir16lcbbc58m6xazxj8xhprgnsyyqhxsam0c7ki697iasy4y7";
#        };
#      }));
#    };


#    piglit = pkgs.callPackage ../pkgs/piglit/default.nix { };

    piglit-patched = (import <nixpkgs> { config.packageOverrides = pkgs: rec {
      waffle = pkgs.callPackage ../pkgs/waffle/default.nix { };
      mesa = (import <nixpkgs> { config.packageOverrides = pkgs: rec {
        mesa_noglu = lib.makeOverridable (args: lib.overrideDerivation pkgs.mesa_noglu (attrs: rec {
          name = "mesa-noglu-${version}";
          version = "10.4.6";

          src = pkgs.fetchurl {
            urls = [
              "https://launchpad.net/mesa/trunk/${version}/+download/MesaLib-${version}.tar.bz2"
              "ftp://ftp.freedesktop.org/pub/mesa/${version}/MesaLib-${version}.tar.bz2"
            ];
            sha256 = "0d97l3ydlwv8r9bw1z71ipk94253b4yy41bvba5dkk3r1v9fvfnq";
          };
        })) { };
      }; }).mesa;
    }; }).callPackage ../pkgs/piglit/default.nix {};
  });
}
