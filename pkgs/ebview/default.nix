{ stdenv, fetchurl, gnome, libeb, pkgconfig }:

stdenv.mkDerivation rec {
  name = "ebview-${version}";
  version = "0.3.6";

  src = fetchurl {
    url = "mirror://sourceforge/ebview/ebview-${version}.tar.gz";
    sha256 = "1c9k66bcvpzkk660parpcqkfi7prcjl5gc9wqbbmsysnn7cyk32c";
  };

  buildInputs = [ gnome.gtk libeb pkgconfig ];

  configureFlags = "--with-eb-conf=${libeb}/etc/eb.conf";

  # ebview uses the deprecated "GtkTooltips" API, among other things
  CFLAGS = "-U GTK_DISABLE_DEPRECATED";

  meta = {
    description = "EPWING dictionary viewer";
    homepage = http://ebview.sourceforge.net/;
    license = stdenv.lib.licenses.gpl2;
    maintainers = [ stdenv.lib.maintainers.auntie ];
  };
}
