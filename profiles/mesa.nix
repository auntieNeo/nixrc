{ config, lib, pkgs, ... }:

let
  customPiglit = { mesa_src ? pkgs.mesa.src }:
  let
    libdrm_2_4_65 = pkgs: (pkgs.libdrm.overrideDerivation (attrs: rec {
      name = "libdrm-${version}";
      version = "2.4.65";

      src = pkgs.fetchurl {
        url = "http://dri.freedesktop.org/libdrm/${name}.tar.bz2";
        sha256 = "1i4n7mz49l0j4kr0dg9n1j3hlc786ncqgj0v5fci1mz7pp40m5ki";
      };
    }));
  in
  (import <nixpkgs> { config.packageOverrides = pkgs: rec {
    waffle = pkgs.callPackage ../pkgs/waffle/default.nix { };

    mesa_override_env = (import <nixpkgs> { config.packageOverrides = pkgs: rec {
      # Inside here, we create an environment in which we override mesa and
      # some of the packages that Mesa depends on.
      mesa_noglu = lib.makeOverridable (args: lib.overrideDerivation pkgs.mesa_noglu (attrs: rec {
        name = "mesa-noglu-${version}";
        version = "git";

        enableParallelBuilding = true;
        src = mesa_src;
        nativeBuildInputs = [ pkgs.pythonPackages.Mako ] ++ attrs.nativeBuildInputs;
      })) {};
      libdrm = libdrm_2_4_65 pkgs;
          
    };});
    mesa = mesa_override_env.mesa;
    mesa_drivers = mesa_override_env.mesa_drivers;
  };}).callPackage ../pkgs/piglit/default.nix {};

  mesa_arb_shader_subroutine = pkgs.fetchgit {
    url = "file:///home/auntieneo/code/mesa";
    rev = "refs/remotes/airlied/arb_shader_subroutine";
    sha256 = "5a1a760d217e2aff1549896a65a0a84cd06fa37ec092d989b23284396882c51c";
  };

  mesa_git = pkgs.fetchgit {
    url = "file:///home/auntieneo/code/mesa";
    rev = "refs/heads/master";
    sha256 = "0baa3c0b0f090d71ad1410e832c3316e3ffebffd94af39f11b5dc891e77b8a17";
  };
in
{
  environment.systemPackages = with pkgs; [
#    piglit
#    piglit-patched
#    piglit-test
    piglit-arb_shader_subroutine
  ];
  nixpkgs.config.packageOverrides = pkgs:
    (let
    in
    rec {

    piglit-arb_shader_subroutine = customPiglit { mesa_src = mesa_arb_shader_subroutine; };
#    piglit-mesa_git = customPiglit { mesa_src = mesa_git; };

#    piglit = pkgs.callPackage ../pkgs/piglit/default.nix { };

#    piglit-patched = (import <nixpkgs> { config.packageOverrides = pkgs: rec {
#      waffle = pkgs.callPackage ../pkgs/waffle/default.nix { };
#
#      mesa_override_env = (import <nixpkgs> { config.packageOverrides = pkgs: rec {
#        # Inside here, we create an environment in which we override mesa and
#        # some of the packages that Mesa depends on.
#        mesa_noglu = lib.makeOverridable (args: lib.overrideDerivation pkgs.mesa_noglu (attrs: rec {
#          name = "mesa-noglu-${version}";
#          version = "git";
#
#          enableParallelBuilding = true;
#          src = pkgs.fetchgit {
#            url = "file:///home/auntieneo/code/mesa";
#            rev = "refs/heads/master";
#            sha256 = "0baa3c0b0f090d71ad1410e832c3316e3ffebffd94af39f11b5dc891e77b8a17";
#          };
#          nativeBuildInputs = [ pkgs.pythonPackages.Mako ] ++ attrs.nativeBuildInputs;
#        })) {};
#
#        libdrm = libdrm_2_4_65 pkgs;
#        
#      }; });
#      mesa = mesa_override_env.mesa;
#      mesa_drivers = mesa_override_env.mesa_drivers;
#    }; }).callPackage ../pkgs/piglit/default.nix {};


#    piglit-test = pkgs.callPackage mesa/piglits/master.nix { piglit = piglit-patched; };
  });
}
