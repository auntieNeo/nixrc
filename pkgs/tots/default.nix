{ stdenv, fetchgit,
  boost, cmake, glew, gmock, graphviz, gtest, lua5_2, mesa, pkgconfig, SDL2
}:

stdenv.mkDerivation rec {
  name = "tots-${version}";
  version = "git";

  src = fetchgit {
    url = "file:///home/auntieneo/code/tots";
    rev = "refs/heads/game_loop";
    sha256 = "ece41f1607e28bc5bcf7ea2d768487159bd154a0db3c2d393566ce634f96819b";
  };

  buildInputs = [ boost cmake glew gmock gtest SDL2 ];
}
