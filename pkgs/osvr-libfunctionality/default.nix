{ stdenv, fetchgit, cmake }:

stdenv.mkDerivation rec {
  name = "osvr-libfunctionality-${version}";
  version = "git";

  src = fetchgit {
    url = https://github.com/OSVR/libfunctionality.git;
    rev = "315e78670551e10ebd1a4e86953a571561c0ee85";
    sha256 = "b144b295a619b0f63674d559df36dd2c9df0ad62aa2ca29bcff003d169842daa";
  };

  buildInputs = [ cmake ];
}
