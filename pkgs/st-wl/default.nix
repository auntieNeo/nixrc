{ stdenv, fetchgit, fontconfig, libwld, libxkbcommon, ncurses, pixman, pkgconfig, wayland }:

stdenv.mkDerivation rec {
  name = "st-wl-${version}";
  version = "cb8abfd49d35df14aed49664608955c9af170ff5";

  src = fetchgit {
    url = "https://github.com/michaelforney/st.git";
    rev = "61b47b76a09599c8093214e28c48938f5b424daa";
    sha256 = "b08e9907a7899ac9ad864a361d7dc33f6a0b5b125844ee6527900b771b844a27";
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
