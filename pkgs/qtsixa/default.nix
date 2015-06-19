{ stdenv, fetchurl, bluez, libusb, libjack2, pkgconfig, pyqt4 }:

stdenv.mkDerivation rec {
  name = "qtsixa-${version}";
  version = "1.5.1";

  src = fetchurl {
    url = "mirror://sourceforge/qtsixa/QtSixA%20${version}/QtSixA-${version}-src.tar.gz";
    sha256 = "1zrn2c8b1dclc11y0795g6qghg6lflyx0jypjijj8f7snkws84a1";
  };

  patches = [ ./QtSixA-1.5.1-unistd-fix.patch ];

  buildInputs = [ bluez libusb libjack2 pkgconfig pyqt4 ];

  installPhase = ''
    make DESTDIR="$out" install
    mv "$out"/usr/{bin,sbin,share} "$out"
    rmdir "$out"/usr
    chmod -R +x "$out"/bin
  '';
}
