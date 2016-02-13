{ stdenv, fetchurl, fetchgit, fontconfig, libdrm, libevdev, libinput, libwld, libxcb, libxkbcommon, pixman, pkgconfig, udev, wayland, xcbutilwm, ... }:

stdenv.mkDerivation rec {
  name = "libswc-${version}";
  version = "git";

  src = fetchgit {
    url = "https://github.com/michaelforney/swc.git";
    rev = "4926291e357cec86e91b804124ce533fb5a9b7aa";
    sha256 = "2963eb36dac12c0146705ab2d4fbcd0d7264be29c0b86f260377427e1c043981";
  };
#  src = fetchgit {
#    url = "file:///home/auntieneo/code/extern/swc/";
#    rev = "16229f0b14f8406d3d59ba2ba7f64bce15f041a3";
#    sha256 = "8abe3f158a31a361ac479788af8257c07a8991a007b6b78cec3bb9f199c5d039";
#  };

  buildInputs = [
    fontconfig
    libdrm
    libevdev
    libinput
    libwld
    libxcb
    libxkbcommon
    pixman
    pkgconfig
    udev
    wayland
    xcbutilwm
  ];

  makeFlags = "-e PREFIX=\${out}";

  meta = {
    description = "A library for making a simple Wayland compositor";
    homepage = https://github.com/michaelforney/swc;
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.auntie ];
  };
}
