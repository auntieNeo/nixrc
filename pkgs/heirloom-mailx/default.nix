{ stdenv, /* fetchurl, */ fetchcvs, coreutils, openssl, /* nspr, nss, */ postfix }:

stdenv.mkDerivation rec {
  name = "heirloom-mailx-${version}";
  version = "12.4";

#  src = fetchurl {
#    url = "mirror://sourceforge/heirloom/heirloom-mailx/${version}/mailx-${version}.tar.bz2";
#    sha256 = "0skiwn2rwl1zp4sj4ywx7smrfg7g62ikfx68ch1vqip3kxv1w84j";
#  };
  src = fetchcvs {
    date = "2015-04-18";
    cvsRoot = ":pserver:anonymous@nail.cvs.sourceforge.net:/cvsroot/nail";
    module = "nail";
    sha256 = "c373f98cfe3fa934b556d6466c192e79af7f19b3dc9d91ca6f31ed185b2cff5e";
  };

  preBuild = ''
    makeFlagsArray=( \
        PREFIX="''${out}" \
        SYSCONFDIR="''${out}/etc" \
        UCBINSTALL="${coreutils}/bin/install" \
        SENDMAIL="${postfix}/bin/sendmail" \
        INCLUDES="-I${openssl}/include" \
        LDFLAGS="-L${openssl}/lib" \
        IPV6="-DHAVE_IPv6_FUNCS" \
    )
  '';
# INCLUDES="-I${nspr}/include/nspr -I${nss}/include/nss" \
# LDFLAGS="-L${nspr}/lib -L${nss}/lib" \

}
