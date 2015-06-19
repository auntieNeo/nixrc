{ stdenv, fetchgit, alsaLib, freetype, mesa, openssl, pkgconfig, python27Packages, scons, xlibs }:

stdenv.mkDerivation rec {
  name = "godot-${version}";
  version = "1.1";

  src = fetchgit {
    url = https://github.com/okamstudio/godot.git;
    rev = "refs/tags/${version}-stable";
    sha256 = "46094d849f661ed47a796a37ece3667230eb0d4960b25ea6a5d02c247aa56b09";
  };

  buildInputs = [ alsaLib freetype mesa openssl pkgconfig python27Packages.python scons xlibs.libX11 xlibs.libXcursor xlibs.libXinerama ];

  patchPhase = ''
    sed -i 's/^env_base=/env_base=Environment(tools=custom_tools,ENV=os.environ);/' ./SConstruct
  '';

  buildPhase = ''
    scons prefix=$out platform=x11
  '';

  installPhase = ''
    mkdir "$out"
    cp -r ./bin "$out"

    # Copy the rest (I'm not sure how much of this is useful, but some of it is)
    mkdir -p "$out"/share/godot
    find . -mindepth 1 -maxdepth 1 ! -name 'bin' ! -name 'share' -exec cp -r {} "$out"/share/godot \;
  '';
}
