{ pkgs }:

{
  xmonadEnv = pkgs.haskellPackages_ghc782.ghcWithPackages (p: with p; [
    xmonad xmonadContrib xmonadExtras xmobar
  ]);
}
