{ stdenv, fetchurl, perl, zlib }:

stdenv.mkDerivation rec {
  name = "libeb-${version}";
  version = "4.4.3";

  src = fetchurl {
    url = "ftp://ftp.sra.co.jp/pub/misc/eb/eb-4.4.3.tar.bz2";
    sha256 = "0psbdzirazfnn02hp3gsx7xxss9f1brv4ywp6a15ihvggjki1rxb";
  };

  buildInputs = [ perl zlib ];

  meta = {
    description = "C library for accessing CD-ROM books";
    homepage = http://www.sra.co.jp/people/m-kasahr/eb/index.html;
    license = stdenv.lib.licenses.bsd3;
    maintainers = [ stdenv.lib.maintainers.auntie ];
  };
}
