{ stdenv, fetchgit, boost, cmake, mesa, openscenegraph, osvr-core }:

stdenv.mkDerivation rec {
  name = "osvr-tracker-viewer-${version}";
  version = "git";

  src = fetchgit {
    url = https://github.com/OSVR/OSVR-Tracker-Viewer.git;
    rev = "17fe3f6e91834447e317a6c35bd507ac0b545a68";
    sha256 = "b6dbe3d0c56a06a21b3dfe0b55e66fa2daa8321bfcefd50e44298e60d0723c89";
  };

  buildInputs = [ boost cmake mesa openscenegraph osvr-core ];
}
