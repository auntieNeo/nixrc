{ stdenv, fetchurl, cmake, mesa, freeglut, zlib, libpng, texLive, xorg }:

stdenv.mkDerivation rec {
  name = "libgl2ps";
  version = "1.3.9";

  src = fetchurl {
    url = "http://geuz.org/gl2ps/src/gl2ps-${version}.tgz";
    sha256 = "0h1nrhmkc4qjw2ninwpj2zbgwhc0qg6pdhpsibbvry0d2bzhns4a";
  };

  buildInputs = [ cmake mesa freeglut zlib libpng texLive xorg.libXi xorg.libXmu ];
}
