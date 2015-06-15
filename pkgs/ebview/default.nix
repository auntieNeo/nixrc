{ stdenv, fetchurl, gnome, libeb, pangox_compat, pkgconfig, xlibs }:

stdenv.mkDerivation rec {
  name = "ebview-${version}";
  version = "0.3.6";

  src = fetchurl {
    url = "mirror://sourceforge/ebview/ebview-${version}.tar.gz";
    sha256 = "1c9k66bcvpzkk660parpcqkfi7prcjl5gc9wqbbmsysnn7cyk32c";
  };

  patches = [
    # EBView uses the deprecated "GtkTooltips" API, among other things. This
    # patch simply removes the GTK_DISABLE_DEPRECATED macro definition.
    ./remove_gtk_disable_deprecated.patch
  ];

  buildInputs = [ gnome.gtk libeb pangox_compat pkgconfig xlibs.libX11 ];

  configureFlags = "--with-eb-conf=${libeb}/etc/eb.conf";

  # The EBView ./configure script does not pick up these libraries
  NIX_CFLAGS_COMPILE = "-I${pangox_compat}/include/pango-1.0";
  NIX_CFLAGS_LINK = "-L${pangox_compat}/lib -lpangox-1.0 -lX11";

  meta = with stdenv.lib; {
    description = "EPWING dictionary viewer";
    homepage = http://ebview.sourceforge.net/;
    license = licenses.gpl2;
    maintainers = with maintainers; [ auntie ];
  };
}
