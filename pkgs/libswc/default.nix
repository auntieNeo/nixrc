{ stdenv, fetchurl, fetchgit, fontconfig, libdrm, libevdev, libinput, libwld, libxcb, libxkbcommon, pixman, pkgconfig, udev, wayland, xcbutilwm, ... }:

stdenv.mkDerivation rec {
  name = "libswc-${version}";
  version = "b189935d7f172f23ee93cd3239bc1630e20669be";

#  src = fetchurl {
#    url = "https://github.com/michaelforney/swc/archive/${version}.tar.gz";
#    sha256 = "2f8df31223894b801e8dc1428a87b099e2c6ff44aa78e46e35bf0663248712f9";
#  };
  src = fetchgit {
    url = "file:///home/auntieneo/code/extern/swc/";
    rev = "16229f0b14f8406d3d59ba2ba7f64bce15f041a3";
    sha256 = "8abe3f158a31a361ac479788af8257c07a8991a007b6b78cec3bb9f199c5d039";
  };

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
