{ lib, buildFHSUserEnv, config }:

buildFHSUserEnv {
  name = "unity-editor";

  targetPkgs = pkgs:
    [
      pkgs.unity-editor-original
    ];
}
