{ stdenv, fetchurl, linuxHeaders, linux_3_18 }:

stdenv.mkDerivation rec {
  name = "dahdi-linux-${version}";
  version = "2.10.1";

  src = fetchurl {
    url = "http://downloads.asterisk.org/pub/telephony/dahdi-linux/dahdi-linux-${version}.tar.gz";
    sha256 = "1aj3i1wccal9rqwl6ffmhkqzdihgb661zxqxfgwp4qzwj3hk5icl";
  };

  # Firmware tarballs (generated with ./updateFirmware.pl ${version})
  dahdi-fw-oct6114-032 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-oct6114-032-1.05.01.tar.gz;
    sha256 = "7a006073202d67e45f1d5ff1e9c6e8663e6056cef9dc4c5abae86a1018db349c";
  };
  dahdi-fw-oct6114-064 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-oct6114-064-1.05.01.tar.gz;
    sha256 = "56bac1f2024c76ecf9b6f40992eeea29a1fbee676bb2a37a058179bacfbb1c91";
  };
  dahdi-fw-oct6114-128 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-oct6114-128-1.05.01.tar.gz;
    sha256 = "e1146749d205c41603b9b76852c3f8104dac233d0025d700db24504d10c99775";
  };
  dahdi-fw-oct6114-256 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-oct6114-256-1.05.01.tar.gz;
    sha256 = "5fe5036a2766cf0e8a968b0c58b700507d86e1cde9296ca437170cc626a9c79c";
  };
  dahdi-fw-tc400m-MR6_12 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-tc400m-MR6.12.tar.gz;
    sha256 = "11dd8d009809e41fc9a3a36766f59ff73d29075eede5b8724331d9a6e5259774";
  };
  dahdi-fw-hx8 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-hx8-2.06.tar.gz;
    sha256 = "449ab3fd03d55d808e999efb7677cd04de202b92c9fcb039539a7e48a39a80f5";
  };
  dahdi-fw-vpmoct032 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-vpmoct032-1.12.0.tar.gz;
    sha256 = "6b199cf836f150f9cb35f763f0f502fb52cfa2724a449b500429c746973904ad";
  };
  dahdi-fw-te820 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-te820-1.76.tar.gz;
    sha256 = "5b823e25828e2c1c6548886ad408b2e31dbc8cd17170c52592792d9c754a199c";
  };
  dahdi-fw-te133 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-te133-780019.tar.gz;
    sha256 = "6a255642301ab46f0bcccf4671ce41096c4733b7308719474e9c6fbcff77cc0e";
  };
  dahdi-fw-te134 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-te134-780017.tar.gz;
    sha256 = "99f7c410bf47d2a5ae687d717e51448ce5b52aca902830bf39bffe683150fa2d";
  };
  dahdi-fw-a8b-1d0019 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-a8b-1d0019.tar.gz;
    sha256 = "65817314ea97ec17520296ec78691bbe6da35b1a43051caae2d8b544f9efd011";
  };
  dahdi-fw-a8a-1d0017 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-a8a-1d0017.tar.gz;
    sha256 = "5064f9877b8aec99b19fd57988216fe1a9c0b7c07853dd3b32b5a55ab7b418e6";
  };
  dahdi-fw-a4b-b0019 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-a4b-b0019.tar.gz;
    sha256 = "84bf8a1a9f61598b3261a6d737529837ca0f56ace77b56467d701e6aa22c04bd";
  };
  dahdi-fw-a4a-a0017 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-a4a-a0017.tar.gz;
    sha256 = "d5b6ab6851e431afcfec2ecc39d95fa88fe3939ffdb2e3d4f28a43cabf30e95b";
  };
  dahdi-fw-te435-e0019 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-te435-e0019.tar.gz;
    sha256 = "0084354638b86666b685a48201791c85639280901519f54a79d586aedb848a3b";
  };
  dahdi-fw-te436 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fw-te436-10017.tar.gz;
    sha256 = "0980f4a8d191c6872aa27d971758046f0e7827ac161549f2cc1b0eeab0ae9333";
  };
  dahdi-fwload-vpmadt032 = fetchurl {
    url = http://downloads.digium.com/pub/telephony/firmware/releases/dahdi-fwload-vpmadt032-1.25.0.tar.gz;
    sha256 = "3ff26cf80555fd7470b43a87c51d03c1db2a75abcd4561d79f69b6c48298e4a1";
  };

  preBuild = ''
    cd drivers/dahdi/firmware
    ln -s ${dahdi-fwload-vpmadt032} ./dahdi-fwload-vpmadt032-1.25.0.tar.gz
    echo "${linux_3_18.config}" > .config
  '';

  buildInputs = [ linux_3_18 linuxHeaders ];
}
