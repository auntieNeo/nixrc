rec {
  home = builtins.getEnv "HOME";
#  packageOverrides = import "${home}/.nixpkgs/environments/migrate.nix";
  packageOverrides = import "${home}/.nixpkgs/environments/opengl.nix";
#  packageOverrides = import "${home}/.nixpkgs/environments/xmonad.nix";
}