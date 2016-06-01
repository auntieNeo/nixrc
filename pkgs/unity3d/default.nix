{ stdenv, fetchurl, getopt }:

stdenv.mkDerivation rec {
  name = "${program}-original-${version}";
  program = "unity";
  version = "5.1.0f3";

  src = fetchurl {
#    url = http://download.unity3d.com/download_unity/unity-editor-installer-5.1.0f3+2015082501.sh;
    url = file:///tmp/unity-editor-installer-5.1.0f3+2015082501.sh;
    sha256 = "14slkp8ifnmxi41bg92gjq5l1qzs6gmi0l6mpcfjfnz179lyfwxz";
  };

  buildInputs = [ getopt ];

  unpackCmd = ''
    sh $src -o ${sourceRoot}'';
  sourceRoot = "unity-editor";

  buildPhase = ''
    mkdir $out
    sh $src
  '';
}
