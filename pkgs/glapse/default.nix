{ stdenv, fetchurl, ffmpeg, gettext, makeWrapper, python, pythonPackages, scrot }:

stdenv.mkDerivation rec {
  name = "glapse-${version}";
  version = "0.3";

  src = fetchurl {
    url = "https://github.com/downloads/siondream/glapse/${name}.tar.gz";
    sha256 = "0rn5zlwf9scg8vpx8phcpk61s5q5rl17q75a2pk6bd4wmsbbhrj8";
  };

  patches = [ ./fix-paths.patch ];

  postPatch = ''
    sed -i 's|@out@|'"$out"'|g' \
      ./glapse \
      ./glapseControllers/configuration.py
  '';

  buildInputs = [ gettext makeWrapper ];
  propagatedBuildInputs = with pythonPackages; [ ffmpeg scrot python pythonPackages.pyGtkGlade ];

  installFlags = "PREFIX=$(out)";

  preInstall = ''
    mkdir -p "$out"/share/locale/{es,en,de,fr,ja}
    sed -i 's|/usr/lib/glapse/|'"$out"'/lib/glapse/|' ./glapse
  '';

  postInstall = ''
    wrapProgram "$out"/bin/glapse --prefix PYTHONPATH : "$PYTHONPATH"
  '';

}
