{ stdenv, fetchgit, mesa, SDL2, SDL2_image, SDL2_mixer }:

stdenv.mkDerivation rec {
  name = "tesseract-game-${version}";
  version = "git";

  src = fetchgit {
    url = file:///home/auntieneo/code/tesseract;
    rev = "refs/heads/master";
# r!printf '    sha256 = "\%s";' `nix-prefetch-git file:///home/auntieneo/code/tesseract --rev refs/heads/master 2>&/dev/null | tail -n1`
    sha256 = "b1682755f93e14fc8065a46cb6e206ab947f26468bc19fce4bd3c1ef421170be";
  };

  buildInputs = [ mesa SDL2 SDL2_image SDL2_mixer ];

  preBuild = ''
    cd src
  '';

  installPhase = ''
    cd ..

    mkdir -p "$out"/share/tesseract
    cp -r ./media ./config ./src/tess_{client,server} "$out"/share/tesseract/

    # Make a short script for the client executable
    mkdir -p "$out"/bin
    cp ${./tess_client} "$out"/bin/tess_client
    sed -i 's|@tess_data@|'"$out"'/share/tesseract|g' \
      "$out"/bin/tess_client
  '';
}
