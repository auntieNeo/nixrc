{ pkgs, ... }:

{
  tots = pkgs.myEnvFun {
    name = "tots";
    buildInputs = with pkgs; [
      allegro5
      boost
      cmake
      gdb
      glew
      gmock
      graphviz
      gtest
      lua5_2
      mesa
      pkgconfig
      SDL2
      xorg_sys_opengl
    ];
  };
}
