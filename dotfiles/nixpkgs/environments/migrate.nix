{ pkgs, ... }:

{
  let
    stdenv = pkgs.stdenv;
  in rec {
    migrate = pkgs.myEnvFun {
      name = "migrate";
      buildInputs = with pkgs; [
        bash
        findutils
        python3
        python3Packages.pexpect
        python3Packages.zc_buildout_nix
        stdenv
        which
      ];
    };
  };
}
