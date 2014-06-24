{
  packageOverrides = pkgs: rec {
    opengl = pkgs.myEnvFun {
      name = "opengl";
      buildInputs = with pkgs; [
        cmake
        mesa
        pkgconfig
        SDL2
      ];
    };
  };
}
