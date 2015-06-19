{ config, lib, pkgs, ... }:

{
  # install development packages
  environment.systemPackages = with pkgs; [
    binutils
    cgdb
    cmake
    doxygen
    eclipses.eclipse_cpp_43
    gdb
#    git-review  # TODO
    godot
    mercurial
    netbeans
    nixops
    patchutils
    python
#    polish-shell
    pwclient
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

  # custom packages
  nixpkgs.config.packageOverrides = pkgs: rec {
    godot = pkgs.callPackage ../pkgs/godot/default.nix { };
    polish-shell = pkgs.callPackage ../pkgs/polish-shell/default.nix { };
    pwclient = pkgs.callPackage ../pkgs/pwclient/default.nix { };
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

  # Enable core dump handling in systemd.
  systemd.coredump = {
    enable = true;
#    extraConfig = ''
#      Storage=journal
#    '';
  };
  security.pam.loginLimits = [
    # Enable core dump files.
    { domain = "*"; type = "-"; item = "core"; value = "unlimited"; }
  ];
  boot.kernel.sysctl = {
    # Enable core dumps even for setuid processes
    "fs.suid_dumpable" = 1;
  };
}
