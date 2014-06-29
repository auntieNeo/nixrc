{ pkgs, ... }:

{
  wld = pkgs.myEnvFun {
    name = "wld";
    buildInputs = with pkgs; [
      libdrm
      fontconfig
      pixman
      pkgconfig
      wayland
    ];
  };
}
