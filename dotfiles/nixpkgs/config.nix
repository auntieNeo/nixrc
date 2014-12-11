rec {
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
    # Environment for developing programs that use ncurses.
    ncurses-dev = pkgs.myEnvFun {
      name = "ncurses";
      buildInputs = with pkgs; [
        curses
        ncurses
      ];
    };

    # Environment for developing swc-based window managers.
    # See htpps://github.com/michaelforney/swc
    swc = pkgs.myEnvFun {
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
    teensy = pkgs.myEnvFun {
      name = "teensy";
      buildInputs = with pkgs; [
        arduino_core
        avrgcclibc
        teensy-loader
      ];
    };

    # Environment I am using for developing a game engine.
    tots = pkgs.myEnvFun {
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
        xorg_sys_opengl
      ];
    };
  };
}
