{ stdenv, fetchurl, fontconfig, libwld, libxkbcommon, ncurses, pixman, pkgconfig, wayland }:

stdenv.mkDerivation rec {
  name = "st-wl-${version}";
  version = "cb8abfd49d35df14aed49664608955c9af170ff5";

  src = fetchurl {
    url = "https://github.com/michaelforney/st/archive/${version}.tar.gz";
    sha256 = "1d29ab652afb437e2581e65e41c628169c50859bbf2a7e673e431dce3bd43c40";
  };

  buildInputs = [ fontconfig libwld libxkbcommon ncurses pixman pkgconfig wayland ];

  NIX_LDFLAGS = "-lfontconfig -lwayland-client -lwayland-cursor -lwld -lxkbcommon";

  installPhase = ''
    TERMINFO=$out/share/terminfo make install PREFIX=$out
  '';

  preFixup = ''
    mv $out/bin/st $out/bin/st-wl
  '';

  meta = {
    description = "simple terminal emulator for swc/wayland which sucks less";
    homepage = https://github.com/michaelforney/st;
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.auntie ];
  };
}
