rec {
  home = builtins.getEnv "HOME";
  packageOverrides = pkgs: {
    migrate = import "${home}/.nixpkgs/environments/migrate.nix" { pkgs=pkgs; };
    opengl = (import "${home}/.nixpkgs/environments/opengl.nix" { pkgs=pkgs; }).opengl;
    swc = import "${home}/.nixpkgs/environments/swc.nix" { pkgs=pkgs; };
    wld = import "${home}/.nixpkgs/environments/wld.nix" { pkgs=pkgs; };
    tots = import "${home}/.nixpkgs/environments/tots.nix" { pkgs=pkgs; };
    xmonad = import "${home}/.nixpkgs/environments/xmonad.nix" { pkgs=pkgs; };
  };
}
