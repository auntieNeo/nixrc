{ pkgs, ... }:

{
  deploy = pkgs.myEnvFun {
    name = "deploy";
    buildInputs = with pkgs; [
      bash
      findutils
      stdenv
      which
      ansible
    ];
  };
}

