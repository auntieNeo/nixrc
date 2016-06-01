{ stdenv, fetchgit, cmake, boost, jsoncpp, libusb1, opencv, osvr-libfunctionality, python, SDL2 }:

stdenv.mkDerivation rec {
  name = "osvr-core-${version}";
  version = "git";

  src = fetchgit {
    url = https://github.com/OSVR/OSVR-Core.git;
    rev = "01950205a6b1f043dd1bab490df5561eed2709a1";
    sha256 = "77968282a7948a116c629af4dbfb9e6015e3ff80a8aa163ebeea23a2f2047459";
  };

  buildInputs = [ cmake boost jsoncpp libusb1 opencv osvr-libfunctionality python SDL2 ];
}
