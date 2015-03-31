{ stdenv, fetchurl }:

stdenv.mkDerivation rec{
  name = "gentoo-${version}";
  version = "20150319";

  stageTarball = fetchurl {
    url = "http://mirror.usu.edu/mirrors/gentoo/releases/amd64/autobuilds/20150319/stage3-amd64-${version}.tar.bz2";
    sha256 = "1nccabr34ix0f0zzwlhd7mg385k1rsaqw6ihg46dcbylab2jsvyp";
  };

#  unpackPhase = ''
#    mkdir chroot
#    tar xjf ${stageTarball} -C chroot
#  '';

  installPhase = ''
    mv chroot/* $out
  '';
}
