{ stdenv, fetchurl, bison, cmake, flex }:

stdenv.mkDerivation rec {
  name = "polish-shell-${version}";
  version = "cd8e1c9bdcb6afb78d8c35140a8545bc83d3cf4c";

  src = fetchurl {
    url = "https://github.com/auntieNeo/polish-shell/archive/${version}.tar.gz";
    sha256 = "b558fd1e6c41051cf819262cfe938ceaafd362dcad0a0e6a4854df6f27b0001d";
  };

  buildInputs = [ bison cmake flex ];

  meta = {
    description = "A mixed polish notation (prefix and RPN) shell experiment";
    homepage = https://github.com/auntieNeo/polish-shell;
    license = stdenv.lib.licenses.gpl3;
    maintainers = [ stdenv.lib.maintainers.auntie ];
  };
}
