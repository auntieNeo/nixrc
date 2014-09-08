rec {
  home = builtins.getEnv "HOME";
#  packageOverrides = import "${home}/.nixpkgs/environments/migrate.nix";
#  packageOverrides = import "${home}/.nixpkgs/environments/opengl.nix";
#  packageOverrides = import "${home}/.nixpkgs/environments/swc.nix";
#  packageOverrides = import "${home}/.nixpkgs/environments/wld.nix";
  packageOverrides = import "${home}/.nixpkgs/environments/teensy.nix";
#  packageOverrides = import "${home}/.nixpkgs/environments/tots.nix";
#  packageOverrides = import "${home}/.nixpkgs/environments/xmonad.nix";
#  packageOverrides = import "${home}/.nixpkgs/livemedia/installer.nix";
}
