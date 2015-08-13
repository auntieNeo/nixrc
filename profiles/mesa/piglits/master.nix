{ stdenv, piglit }:

stdenv.mkDerivation rec {
  name = "piglit-test-${version}";
  version = "git-${rev}";
  rev = "";

  buildCommand = ''
    mkdir -p "$out"/result
    # TODO: check LIBGL_DRIVERS_PATH
    # TODO: make X11 display available (avoid XOpenDisplay failed error)
    ${piglit}/bin/piglit run ${piglit}/lib/piglit/tests/quick "$out"/result
  '';
}
