{ stdenv, fetchurl, mecab-nodic }:

let
  mecab-nodic = rec {
    name = "mecab-nodic-${version}";
    version = "0.996";

    src = fetchurl {
      url = https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE;
      name = "mecab-0.996.tar.gz";
      sha256 = "0ncwlqxl1hdn1x4v4kr2sn1sbbcgnhdphp0lcvk74nqkhdbk4wz0";
    };

    buildPhase = ''
      make
      make check
    '';
  };
in
let
  mecab-ipadic = stdenv.mkDerivation rec {
    name = "mecab-ipadic-${version}";
    version = "2.7.0-20070801";

    src = fetchurl {
      url = https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM;
      name = "mecab-ipadic-2.7.0-20070801.tar.gz";
      sha256 = "08rmkvj0f0x6jq0axrjw2y5nam0mavv6x77dp9v4al0wi1ym4bxn";
    };

    buildInputs = [ stdenv.mkDerivation mecab-nodic ];
  };
in
stdenv.mkDerivation (mecab-nodic // {
    name = "mecab-${mecab-nodic.version}";
    postInstall = ''
      sed -i 's/^dicdir = .*$/dicdir = ${ipadic}/lib/mecab/dic/ipadic/' "$out/etc/mecabrc"
    '';
})
