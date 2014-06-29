{ pkgs, ... }:

{
  swc = pkgs.myEnvFun {
    name = "swc";
    buildInputs = with pkgs; [
      fontconfig
      libdrm
      libevdev
      libwld
#      libxcb
      libxkbcommon
      pixman
      pkgconfig
      udev
      wayland
#      xcbutilwm
    ];
  };
}
