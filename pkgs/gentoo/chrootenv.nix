{ buildFHSUserEnv, config }:

buildFHSUserEnv {
  name = "gentoo";

  targetPkgs = pkgs:
    [ pkgs.gentoo-original
    ];

  runScript = "exec bash";
}
