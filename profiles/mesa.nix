{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
#    piglit
#    piglit-patched
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
          version = "git";
#          version = "10.4.6";

          enableParallelBuilding = true;
          src = pkgs.fetchgit {
            url = "file:///home/auntieneo/code/mesa";
            rev = "refs/heads/arb_shader_subroutine";
            sha256 = "96399a2f56429375bdea403d0abbf0c9731d251e52d93e4e198e917ec8865eea";
#            rev = "refs/heads/master";
#            sha256 = "6b4a4cacbb958c5e5f928b0f16d74e1f40537433edcd5ed421312ce7afead443";
          };
#          src = pkgs.fetchurl {
#            urls = [
#              "https://launchpad.net/mesa/trunk/${version}/+download/MesaLib-${version}.tar.bz2"
#              "ftp://ftp.freedesktop.org/pub/mesa/${version}/MesaLib-${version}.tar.bz2"
#            ];
#            sha256 = "0d97l3ydlwv8r9bw1z71ipk94253b4yy41bvba5dkk3r1v9fvfnq";
#          };
          nativeBuildInputs = [ pkgs.pythonPackages.Mako ] ++ attrs.nativeBuildInputs;
        })) { };
      }; }).mesa;
    }; }).callPackage ../pkgs/piglit/default.nix {};
  });
}
