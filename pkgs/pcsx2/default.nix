{ stdenv, fetchgit, fetchurl, p7zip, alsaLib, bzip2, cmake, gettext, glew, glib, glibcLocales, gtk2, libaio, libjpeg, libpthreadstubs, libXdmcp, libxshmfence, mesa, nvidia_cg_toolkit, perl, pkgconfig, portaudio, SDL, soundtouch, sparsehash, wxGTK30, zlib }:

stdenv.mkDerivation rec {
  name = "pcsx2-${version}";
  version = "1.3.1";

  src = fetchgit {
    url = https://github.com/PCSX2/pcsx2.git;
    rev = "refs/tags/v${version}";
    sha256 = "2f8a5fa3d1633ab2755b1613daaf0de4666cf91e0ba5e5992745435ce6c39d68";
  };

#  src = fetchurl {
#    name = "pcsx2-1.2.1-sources.7z";
#    url = http://pcsx2.net/download/releases/source-code/finish/7-source/121-pcsx2-v1-2-1-source-code/0.html;
#    sha256 = "1w35rjzx96ai7z4c8kbq6jxf48j1lg55qkns4mmrsh65n8hxkiy9";
#  };

  buildInputs = [
    alsaLib bzip2 cmake gettext glew glib glibcLocales gtk2 libaio libjpeg libpthreadstubs libXdmcp libxshmfence mesa
    nvidia_cg_toolkit perl pkgconfig portaudio SDL soundtouch sparsehash wxGTK30 zlib
  ];

#  unpackPhase = ''
#    ${p7zip}/bin/7z x "$src"
#  '';

  cmakeFlags = ''
    -DGTK2_GLIBCONFIG_INCLUDE_DIR=${glib}/lib/glib-2.0/include
    -DGTK2_GDKCONFIG_INCLUDE_DIR=${gtk2}/lib/gtk-2.0/include
    -DGTK2_INCLUDE_DIRS=${gtk2}/include/gtk-2.0/gtk
    -DPACKAGE_MODE=TRUE
  '';

#  installPhase = ''
#    cmake -DCMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION=ON -DCMAKE_INSTALL_PREFIX="$out" -P cmake_install.cmake
#  '';

  enableParallelBuilding = true;
}
