{ stdenv, fetchurl, fontconfig, libdrm, libevdev, libinput, libwld, libxcb, libxkbcommon, pixman, pkgconfig, udev, wayland, xcbutilwm, ... }:

stdenv.mkDerivation rec {
  name = "libswc-${version}";
  version = "b189935d7f172f23ee93cd3239bc1630e20669be";

  src = fetchurl {
    url = "https://github.com/michaelforney/swc/archive/${version}.tar.gz";
    sha256 = "2f8df31223894b801e8dc1428a87b099e2c6ff44aa78e46e35bf0663248712f9";
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
