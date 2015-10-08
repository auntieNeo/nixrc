{ lib, pkgs }:

{
  mesa_noglu,
  libdrm,
  waffle,
  piglit
}:

stdenv.mkDerivation rec {
  name = "piglit-test-result";

}
