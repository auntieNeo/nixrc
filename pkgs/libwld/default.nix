{ stdenv, fetchurl, fontconfig, libdrm, pixman, pkgconfig, wayland, ... }:

stdenv.mkDerivation rec {
  name = "libwld-${version}";
  version = "74f0deabb2a8a0f2e9c2eaebb4e36945716d8ab9";

  src = fetchurl {
    url = "https://github.com/michaelforney/wld/archive/${version}.tar.gz";
    sha256 = "da4f2c862958346ac54a83cf0f1cb4b9734bafbbe0844d7e15447bfcb18d97b4";
  };

  buildInputs = [
    fontconfig
    libdrm
    pixman
    pkgconfig
    wayland
  ];

  makeFlags = "-e PREFIX=\${out}";

  # NOTE: swc-launch requires set-uid to become DRM master
  # See <https://github.com/michaelforney/swc/issues/16>
  meta = {
    description = "A primitive drawing library targeted at Wayland";
    homepage = https://github.com/michaelforney/wld;
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.auntie ];
  };
}
