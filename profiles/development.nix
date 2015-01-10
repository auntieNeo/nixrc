{ config, pkgs, ...}:

{
  # install development packages
  environment.systemPackages = with pkgs; [
    cmake
    doxygen
    eclipses.eclipse_cpp_43
    mercurial
    netbeans
    python
    R
    rubyLibs.jekyll
    scons
    sloccount
    subversionClient
    vagrant
    valgrind
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
}
