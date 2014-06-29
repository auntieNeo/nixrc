{ pkgs, ... }:

{
  tots = pkgs.myEnvFun {
    name = "tots";
    buildInputs = with pkgs; [
      allegro5
      cmake
      lua5_2
      mesa
      pkgconfig
      SDL2
    ];
  };
}
