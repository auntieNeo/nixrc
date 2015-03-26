{ stdenv, fetchgit, cmake, glproto, libdrm, libpthreadstubs,
  libX11, libXau, libXdamage, libXdmcp, libXext, libxshmfence, libXxf86vm,
  mesa, pkgconfig, python27, python27Packages, udev, waffle }:

stdenv.mkDerivation rec {
  name = "piglit-${version}";
  version = "a04c0af968922b694221899d6da5f5a752a304f8";

  src = fetchgit {
    url = git://anongit.freedesktop.org/git/piglit;
    rev = "${version}";
    sha256 = "6989b07fee2b3e716deaf37d948b62b05cfc74f77281a52fdc788b83666071c5";
  };

  buildInputs = [ cmake glproto libdrm libpthreadstubs
    libX11 libXau libXdamage libXdmcp libXext libxshmfence libXxf86vm
    mesa pkgconfig
    python27
    udev waffle ] ++ pythonPath;
  pythonPath = with python27Packages; [ Mako numpy six ];
}
