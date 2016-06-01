{ stdenv, makeWrapper, fetchurl, fpc, lazarus, gdk_pixbuf, gnome, xorg, glib, cairo, atk }:

stdenv.mkDerivation rec {
  name = "spawner-${version}";
  version = "0.2.3";

  src = fetchurl { 
    url = "mirror://sourceforge/spawner/spawner/${name}/${name}-src.tar.gz";
    sha256 = "097dp5dwcy0f1fx0anlv54i8a9ahgaq5gjjk0mh595gcx9zg7fqp";
  };

  buildInputs = [ makeWrapper fpc lazarus gdk_pixbuf gnome.gtk xorg.libX11 glib cairo atk ];

  buildPhase = ''
    mkdir -p ./home/.lazarus
    lazbuild --widgetset=gtk2 --primary-config-path=./home/.lazarus --lazarusdir=${lazarus}/share/lazarus program.lpi
  '';

  installPhase = ''
    ls ${xorg.libX11}/lib
    mkdir -p "$out"/bin
    cp ./bin/spawner "$out"/bin/
    wrapProgram "$out"/bin/spawner \
      --prefix LD_LIBRARY_PATH ':' "${gnome.gtk}/lib" \
      --prefix LD_LIBRARY_PATH ':' "${xorg.libX11}/lib" \
      --prefix LD_LIBRARY_PATH ':' "${gdk_pixbuf}/lib" \
      --prefix LD_LIBRARY_PATH ':' "${glib}/lib" \
      --prefix LD_LIBRARY_PATH ':' "${gnome.pango}/lib" \
      --prefix LD_LIBRARY_PATH ':' "${cairo}/lib" \
      --prefix LD_LIBRARY_PATH ':' "${atk}/lib"
  '';
}
