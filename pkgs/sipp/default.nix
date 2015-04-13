{ stdenv, fetchurl, autoconf, automake, ncurses }:

stdenv.mkDerivation rec {
  name = "sipp-${version}";
  version = "3.4.1";

  src = fetchurl {
    url = "https://github.com/SIPp/sipp/archive/v${version}.tar.gz";
    sha256 = "1i1bm1viz9ak6vncqgm8p7gv94i61vj7vkgz11gqp3dgyfhjjs5v";
  };

  patches = [ ./fix-configure.patch ];

  buildInputs = [ autoconf automake ncurses ];

  preConfigure = ''
    automake --add-missing
    autoreconf
  '';

  meta = {
    description = "Test tool and traffic generator for the SIP protocol";
    homepage = http://sipp.sourceforge.net/;
    license = stdenv.lib.licenses.gpl2;
    maintainers = [ stdenv.lib.maintainers.auntie ];
  };
}
