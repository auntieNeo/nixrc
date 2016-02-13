{ stdenv, fetchgit, fontconfig, libdrm, pixman, pkgconfig, wayland, ... }:

stdenv.mkDerivation rec {
  name = "libwld-${version}";
  version = "git";

  src = fetchgit {
    url = "https://github.com/michaelforney/wld.git";
    rev = "efe0a1ed1856a2e4a1893ed0f2d7dde43b5627f0";
    sha256 = "52e4f64d5086c7b3273403987ff42174ed69bfcf913d4b82f729d7be770728d9";
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
