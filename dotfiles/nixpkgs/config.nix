rec {
  allowUnfree = true;

  home = builtins.getEnv "HOME";
#  packageOverrides = import "${home}/.nixpkgs/environments/migrate.nix";
#  packageOverrides = import "${home}/.nixpkgs/environments/opengl.nix";
#  packageOverrides = import "${home}/.nixpkgs/environments/swc.nix";
#  packageOverrides = import "${home}/.nixpkgs/environments/wld.nix";
#  packageOverrides = import "${home}/.nixpkgs/environments/teensy.nix";
#  packageOverrides = import "${home}/.nixpkgs/environments/tots.nix";
#  packageOverrides = import "${home}/.nixpkgs/environments/xmonad.nix";
#  packageOverrides = import "${home}/.nixpkgs/livemedia/installer.nix";

  packageOverrides = pkgs: {
    # Environment for Java development
    env-java = pkgs.myEnvFun {
      name = "java";
      buildInputs = with pkgs; [
        gradle
        maven
        openjdk
#        openjdk8
      ];
    };

    # Environment for making Jekyll websites
    env-jekyll = pkgs.myEnvFun {
      name = "jekyll";
      buildInputs = with pkgs; let ruby = ruby_2_1; in [
         rubyLibs.jekyll  # FIXME: figure out how to get this to use ruby_2_1
      ];
    };

    # Environment for developing programs that use ncurses.
    env-ncurses = pkgs.myEnvFun {
      name = "ncurses";
      buildInputs = with pkgs; [
        ncurses
      ];
    };

    # Environment for python development.
    env-python = pkgs.myEnvFun {
      name = "python";
      buildInputs = with pkgs; [
        pypyPackages.pyyaml
      ];
    };

    # Environment for developing swc-based window managers.
    # See htpps://github.com/michaelforney/swc
    env-swc = pkgs.myEnvFun {
      name = "swc";
      buildInputs = with pkgs; [
        fontconfig
        libdrm
        libevdev
        libwld
#      libxcb
        libxkbcommon
        pixman
        pkgconfig
        udev
        wayland
#      xcbutilwm
      ];
    };

    # Environment for programming USB Teensy development boards.
    env-teensy = pkgs.myEnvFun {
      name = "teensy";
      buildInputs = with pkgs; [
        arduino_core
        avrgcclibc
        teensy-loader
      ];
    };

    # Environment I am using for developing a game engine.
    env-tots = pkgs.myEnvFun {
      name = "tots";
      buildInputs = with pkgs; [
        allegro5
        boost
        cmake
        gdb
        glew
        gmock
        graphviz
        gtest
        lua5_2
        mesa
        pkgconfig
        SDL2
        stdenv
        xorg_sys_opengl
      ];
    };

    loveEnv = pkgs.stdenv.mkDerivation rec {
       name = "love-env";
       buildInputs = with pkgs; [
         love_0_9
       ];
     };

    env-root = pkgs.myEnvFun {
      name = "root";
      buildInputs = with pkgs; [
        gdb
        root
        stdenv
      ];
    };
  };
}
