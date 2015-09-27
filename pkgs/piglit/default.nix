{ stdenv, fetchgit, cmake, glproto, libdrm, libpthreadstubs,
  libX11, libXau, libXdamage, libXdmcp, libXext, libxshmfence, libXxf86vm,
  makeWrapper, mesa, mesa_drivers, pkgconfig, python, pythonPackages, udev,
  waffle }:

stdenv.mkDerivation rec {
  name = "piglit-${version}";
  version = "a04c0af968922b694221899d6da5f5a752a304f8";

  src = fetchgit {
    url = git://anongit.freedesktop.org/git/piglit;
    rev = "${version}";
    sha256 = "6989b07fee2b3e716deaf37d948b62b05cfc74f77281a52fdc788b83666071c5";
  };

  patches = [
    # The wrapper provided with piglit expects itself to be named 'piglit.py'.
    # This patch accounts for the fact that wrapProgram will rename that
    # wrapper script to '.piglit-wrapped'.
    ./hack-for-wrapper.patch
  ];

  buildInputs = [ cmake glproto libdrm libpthreadstubs
    libX11 libXau libXdamage libXdmcp libXext libxshmfence libXxf86vm
    makeWrapper mesa pkgconfig python udev waffle ];
  propagatedBuildInputs = with pythonPackages; [ Mako numpy six ];

  postInstall = ''
    # piglit might be testing a specific version of Mesa's DRI drivers, but in
    # NixOS DRI drivers are typically search for at runtime in
    # "/run/opengl-driver{,-32}/lib/*". We make an exception to that rule here.
    wrapProgram "$out"/bin/piglit \
      --prefix PYTHONPATH : "$PYTHONPATH" \
      --set LIBGL_DRIVERS_PATH "${mesa_drivers}/lib:${mesa_drivers}/lib/dri"
  '';
}
