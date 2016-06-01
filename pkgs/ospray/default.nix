{ stdenv, fetchurl, cmake, ispc, tbb, mesa, freeglut, qt48Full }:

stdenv.mkDerivation rec {
  name = "ospray-${version}";
  version = "0.9.1";

  src = fetchurl {
    url = "https://github.com/ospray/OSPRay/archive/v${version}.tar.gz";
    sha256 = "1rxhmy6213srrqzyikzhk29gwjayrn8xjv22i6zd4wh9if6rpf3d";
  };

  buildInputs = [ cmake ispc tbb mesa freeglut qt48Full ];
}
