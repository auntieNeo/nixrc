{ stdenv, fetchurl, ncurses }:

stdenv.mkDerivation rec {
  name = "speech_tools-${version}";
  version = "2.4";

  src = fetchurl {
    url = "http://festvox.org/packed/festival/2.4/speech_tools-${version}-release.tar.gz";
    sha256 = "043h4fxfiiqxgwvyyyasylypjkpfzajxd6g5s9wsl69r8hn4ihpv";
  };

  buildInputs = [ ncurses ];

  preBuild = ''
    # Fix some executable paths in makefiles
    for i in /usr/bin/printf /bin/rm; do
      base=$(basename "$i")
      grep -Rl "$i" . \
        | xargs sed -i 's|'"$i"'|/usr/bin/env '"$base"'|'
    done
  '';

  installPhase = ''
    for d in lib bin include config base_class; do
      mkdir -p "$out"/"$d"
    done
    find ./lib -type f -name '*.a' \
        -exec cp '{}' "$out"/lib \;
    mkdir -p "$out"/lib/siod
    find ./lib/siod -type f -name '*.scm' \
        -exec cp '{}' "$out"/lib/siod \;
    find ./bin ./main -type f -executable \
        -exec cp '{}' "$out"/bin \;
    cp -r ./include/* "$out"/include
    find ./include -type f -name Makefile \
        -exec rm '{}' +
    # Unfortunately, Festival shares some common build routines with
    # speech_tools, so we'll copy ./config to the derivation. It can't be
    # helped.
    cp -r ./config/* "$out"/config
    # The speech_tools header files reference some C++ templates outside of
    # the ./include directory. Again, this is unfortunate, but it can't be
    # helped.
    cp -r ./base_class/* "$out"/base_class
    find "$out"/base_class -type f \
                              -name '*.o' \
                           -o -name Makefile \
                           -o -name make.depend \
        -exec rm '{}' +
  '';

  meta = with stdenv.lib; {
    description = "Libraries and utilities used in speech software";
    homepage = http://www.cstr.ed.ac.uk/projects/festival/;
    license = licenses.bsdOriginal;
    maintainers = with maintainers; [ auntie ];
  };
}
