{ config, lib, pkgs, ... }:

{
  # install development packages
  environment.systemPackages = with pkgs; [
    binutils
    cmake
    doxygen
    eclipses.eclipse_cpp_43
    gdb
#    git-review  # TODO
    mercurial
    netbeans
    (lib.overrideDerivation pkgs.nixops (attrs: rec {
      name = "nixops-git-${version}";
      version = "86c35beca37833c5b0abed373e5144702f2e88f6";

      src = pkgs.fetchgit {
        url = https://github.com/NixOS/nixops;
        rev = "${version}";
        sha256 = "204b1846f79fb9db48e44251f6075cab56de6bf49740a73907f7ccc3c26ca660";
      };
    }))
    patchutils
    python
#    polish-shell
    R
#    rubyLibs.jekyll
    scons
    sloccount
    subversionClient
    valgrind
#    vimPlugins.UltiSnips
#    vimPlugins.YouCompleteMe  # YCM is blocking vim process, probably due to vim plugin architecture.
#    afpfs-fuse
  ];

  nix = {
    distributedBuilds = false;
#    requireSignedBinaryCaches = false;  # FIXME
#    buildCores = 0;  # Use all available CPU cores in the system
    buildMachines = [
      {
        hostName = "hazuki";
        maxJobs = 8;
        sshKey = "/home/auntieneo/.ssh/id_rsa";
        sshUser = "auntieneo";
        system = "x86_64-linux";
        supportedFeatures = [ "kvm" "nixos-test" ];
      }
    ];
  };

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

  security.setuidPrograms = [ "mount_afp" ];

  # custom packages
  nixpkgs.config.packageOverrides = pkgs: rec {
    polish-shell = pkgs.callPackage ../pkgs/polish-shell/default.nix { };
  };
}
