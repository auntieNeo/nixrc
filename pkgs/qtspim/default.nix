{ stdenv, fetchsvn, qt5, bison, flex }:

stdenv.mkDerivation rec {
  name = "qtspim-${version}";
  version = "9.1.16";  # version number is specified in the revision message
  revision = "660";

  src = fetchsvn {
    url = svn://svn.code.sf.net/p/spimsimulator/code;
    rev = "${revision}";
    sha256 = "1frfvhh0qwi37zxh0ly2bmwv2x83amb4ys9abyjcj5pafk9637p6";
  };

  patches = [ ./fix-bool-int-declarations.patch ];

  buildInputs = [ qt5.base qt5.tools  bison flex ];

  configurePhase = ''
    cd QtSpim && qmake 'QMAKE_CFLAGS_RELEASE += "-x c++ -Wno-write-strings"' PREFIX=$out
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./QtSpim $out/bin/
  '';
}
