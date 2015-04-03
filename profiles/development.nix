{ config, pkgs, ...}:

{
  imports = [
    ../services/asterisk.nix
  ];

  # install development packages
  environment.systemPackages = with pkgs; [
    asterisk
    cmake
    doxygen
    eclipses.eclipse_cpp_43
    mercurial
    netbeans
    binutils
    piglit
    python
#    polish-shell
    R
#    rubyLibs.jekyll
    scons
    sipp
    sloccount
    subversionClient
    valgrind
#    vimPlugins.UltiSnips
    vimPlugins.YouCompleteMe
  ];

  system.activationScripts =
  {
    # install development environments
    dev_environments = ''
      if [ ! -d /home/auntieneo/.nixpkgs/environments ]; then
        mkdir -p /home/auntieneo/.nixpkgs/environments
      fi
      for f in ${../dotfiles/nixpkgs/environments}/*.nix; do
        ln -fs $f /home/auntieneo/.nixpkgs/environments/
      done
    '';
  };

  services.asterisk = {
    enable = true;
    otherConfig =
    {
      "sip.conf" = ''
        [me1]
        type=friend
        username=me1
        secret=PASSWORD
        host=dynamic
        context=house

        [me2]
        type=friend
        username=me2
        secret=PASSWORD
        host=dynamic
        context=house
      '';
      "extensions.conf" = ''
        [house]
        exten => 100,1,Dial(SIP/me1)
        exten => 101,1,Dial(SIP/me2)
      '';
    };
  };

  # custom packages
  nixpkgs.config.packageOverrides = pkgs: rec {
    asterisk = pkgs.callPackage ../pkgs/asterisk/default.nix { };
    piglit = pkgs.callPackage ../pkgs/piglit/default.nix { };
    polish-shell = pkgs.callPackage ../pkgs/polish-shell/default.nix { };
    sipp = pkgs.callPackage ../pkgs/sipp/default.nix { };
    waffle = pkgs.callPackage ../pkgs/waffle/default.nix { };
  };
}
