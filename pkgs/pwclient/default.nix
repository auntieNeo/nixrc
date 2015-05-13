{ stdenv, fetchgit, makeWrapper, python }:

stdenv.mkDerivation rec {
  name = "pwclient-${version}";
  version = "git-${rev}";
  rev = "8904a7dcaf959da8db4a9a5d92b91a61eed05201";

  src = fetchgit {
    url = "git://ozlabs.org/home/jk/git/patchwork";
    rev = "${rev}";
    sha256 = "c5f4ea659795b63f35ef9c8eaa74c0a701df12042a24b51a2b8fe82465258b35";
  };

  buildInputs = [ makeWrapper python ];

  dontBuild = true;

  installPhase = ''
    mkdir -p "$out"/bin

    cp ./apps/patchwork/bin/pwclient "$out"/bin/pwclient

    wrapProgram "$out"/bin/pwclient --prefix PYTHONPATH : "$PYTHONPATH"
  '';
}
