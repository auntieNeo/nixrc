{ config, pkgs, ... }:

{

  imports = [
    # libswc launch service (Wayland compositor)
    ../services/wayland/swc-launch.nix
#    # Experimental X11 + Wayland display configuration
#    ../services/display/default.nix
  ];

  environment.systemPackages = with pkgs; [
    dmenu
    dmenu-wl
    libswc
    libwld
    st-wl
    velox
  ];

  # Enable swc+velox (Wayland compositor) as alternative to X11
  services.swc-launch = {
    enable = true;
    user = "auntieneo";
    layout = "dvorak";
    xkbOptions = "caps:super";
    server.velox.enable = true;
  };

  nixpkgs.config.packageOverrides = pkgs: rec {
    dmenu-wl = pkgs.callPackage ../pkgs/dmenu-wl/default.nix { };
    libswc = pkgs.misc.debugVersion (pkgs.callPackage ../pkgs/libswc/default.nix { });
    libwld = pkgs.callPackage ../pkgs/libwld/default.nix { };
    st-wl = pkgs.callPackage ../pkgs/st-wl/default.nix { };
    velox = pkgs.callPackage ../pkgs/velox/default.nix { };
  };
}
