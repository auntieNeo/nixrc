{ stdenv, fetchurl, unzip, mesa, qt5 }:

stdenv.mkDerivation rec {
  name = "fourchan-dl-${version}";
  version = "1.7.0";

  src = fetchurl {
    url = "mirror://sourceforge/fourchan-dl/v${version}/fourchan-dl-src-v${version}.zip";
    sha256 = "17qidwmbbngia4iv6py92yli4mdqjm1l8ai8hv0nff1pvy0harlw";
  };

  buildInputs = [ mesa qt5 ];

  unpackPhase = ''
    mkdir ./fourchan-dl
    cd ./fourchan-dl
    ${unzip}/bin/unzip "${src}"
  '';

  configurePhase = ''
    ${qt5}/bin/qmake .
  '';

  installPhase = ''
    mkdir -p ''${out}/bin
    cp ./fourchan-dl{,-console} ''${out}/bin
  '';
}
