{ stdenv, fetchurl, fontconfig, libswc, libwld, libxkbcommon, pixman, pkgconfig, wayland }:

stdenv.mkDerivation rec {
  name = "velox-${version}";
  version = "4e549c62392032ac0c67dd1a135d56f7a99e6c06";

  src = fetchurl {
    url = "https://github.com/michaelforney/velox/archive/${version}.tar.gz";
    sha256 = "c0a7c8ceccc5a536ba48c7b3266fda76392097a5be93cbea27c65a1171f53173";
  };

  buildInputs = [ fontconfig libswc libwld libxkbcommon pixman pkgconfig wayland ];
  
  makeFlags = "PREFIX=\${out}";

  meta = {
    description = "Simple window manager based on swc";
    homepage = https://github.com/michaelforney/velox;
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.auntie ];
  };
}
