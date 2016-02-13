{ stdenv, fetchgit, fontconfig, libswc, libwld, libxkbcommon, pixman, wayland }:

stdenv.mkDerivation rec {
  name = "dmenu-wl-${version}";
  version = "git";

  src = fetchgit {
    url = "https://github.com/michaelforney/dmenu.git";
    rev = "6e08b77428cc3c406ed2e90d4cae6c41df76341e";
    sha256 = "d12256b7788b642aa6bee0b01db2c24358ad5346b3fe51f04b6d6928508ee6fa";
  };

  buildInputs = [ fontconfig libswc libwld libxkbcommon pixman wayland ];

  makeFlags = "SWCPROTO=${libswc}/share/swc/swc.xml PREFIX=\${out}";

  preFixup = ''
    # Patch dmenu scripts to use binaries with -wl suffix.
    for i in dmenu_path dmenu_run; do
      sed -ri -e 's!\<(dmenu|stest)\>!'"$out/bin"'/&-wl!g' $i
    done
    # Rename all executables with the -wl suffix.
    for i in dmenu dmenu_path dmenu_run stest; do
      mv $out/bin/$i $out/bin/$i-wl
    done
  '';

  meta = {
    description = "an efficient dynamic menu for swc/wayland";
    homepage = https://github.com/michaelforney/dmenu;
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.auntie ];
  };
}
