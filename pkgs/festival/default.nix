{ stdenv, fetchurl, ncurses, speech_tools }:

stdenv.mkDerivation rec {
  name = "festival-${version}";
  version = "2.4";

  src = fetchurl {
    url = "http://festvox.org/packed/festival/2.4/festival-${version}-release.tar.gz";
    sha256 = "112xbqz5hlfvdrwxabd1bsrs03h4gja9gbffpkigszw5w29z4iqy";
  };

  buildInputs = [ ncurses speech_tools ];

  preConfigure = ''
    # Set the path to the Edinburgh Speech Tools
    sed -i 's|^EST=.*|EST=${speech_tools}|' ./config/config.in
  '';

  postBuild = ''
    # Fix script pointing to build directory
    sed -i 's|TOP=.*|TOP=$out|' ./bin/festival_server
  '';

  installPhase = ''
    mkdir -p "$out"
    cp -r ./bin ./lib ./doc "$out"
    for i in festival{,_client}; do
      # Replace symlinks with the actual binaries
      rm "$out"/bin/"$i"
      cp ./src/main/"$i" "$out"/bin/"$i"
    done
    # Clean up some build files
    rm "$out"/bin/{Makefile,VCLocalRules}
  '';

}
