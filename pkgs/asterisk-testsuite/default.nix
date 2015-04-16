{ stdenv, fetchsvn, asterisk, lua51Packages }:

let
  asterisk-dev = 
    (stdenv.lib.overrideDerivation asterisk (attrs: rec {
      name = "asterisk-dev-${attrs.version}";

      configureFlags = attrs.configureFlags + " --enable-dev-mode";
    }));
in
stdenv.mkDerivation rec {
  name = "asterisk-testsuite-svn-${version}";
  version = "6564";

  src = fetchsvn {
    url = http://svn.asterisk.org/svn/testsuite/asterisk/trunk;
    rev = "${version}";
    sha256 = "047jzj7a2i7qj0gsb2yl5zwnyak632paqrkx0mhbnc22ivzs83s0";
  };

  buildInputs = [ lua51Packages.lua ] ++ asterisk.buildInputs;

  src_asterisk = "${asterisk.src}";

  preInstall = ''
    sed -i 's|^PREFIX?=.*|PREFIX?='"''${out}"'|' ./asttest/Makefile
  '';
}
