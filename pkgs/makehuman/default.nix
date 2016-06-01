{ stdenv, fetchurl, unzip, makeWrapper, python, pythonPackages }:

stdenv.mkDerivation rec {
  name = "makehuman-${version}";
  version = "1.0.2";

  src = fetchurl {
    url = "https://bitbucket.org/MakeHuman/makehuman/get/${version}.zip";
    sha256 = "1nad29y3hn4wdxjmm0640pvhly3ric66yajk9qnja0zf1vd0z89j";
  };

  buildInputs = [ makeWrapper python unzip ];
  propagatedBuildInputs = with pythonPackages; [ numpy pyopengl pyqt5  ];

  buildPhase = ''
  '';

  installPhase = ''
    mkdir "$out"
    cp -R * "$out"/

    wrapProgram "$out"/makehuman/makehuman \
      --prefix PYTHONPATH : "$PYTHONPATH"
  '';
}
