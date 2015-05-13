{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    ansible
    apg
    aspell
    aspellDicts.en
    bind  # nslookup, dig
    ctags
    expect
    git
    gnupg
    idutils
    inetutils
    irssi
    ledger
    links2
#    mailutils
    heirloom-mailx
    manpages
    mkpasswd
    mosh
    most
    ncurses
#    nkf  # TODO: write a package for Network Kanji Filter
    nix-prefetch-scripts
#    pacman  # TODO: write a package for Arch Linux's pacman (for creating Arch chroots)
    pmutils
    psmisc
    rtorrent
    ruby
    screen
    sshfsFuse
    stdenv
    sudo
    tcpdump
    tmux
    tmuxinator
#    unison
    unison_2_40_102
    unzip
    utillinuxCurses
    vim_configurable
    vlock
    wget
    wgetpaste
    zsh
  ];

  # custom packages
  nixpkgs.config.packageOverrides = pkgs: rec {
    heirloom-mailx = pkgs.callPackage ../pkgs/heirloom-mailx/default.nix { };
    unison_2_40_102 = pkgs.callPackage ../pkgs/unison/unison-2.40.102.nix { lablgtk = pkgs.ocamlPackages.lablgtk; };
  };

  # Enable zsh as a login shell
  programs.zsh.enable = true;

#  # Enable core dump handling in systemd.
#  systemd.coredump = {
#    enable = true;
##    extraConfig = ''
##      Storage=journal
##    '';
#  };

  security.pam.loginLimits = [
    # Enable core dump files.
    { domain = "*"; type = "-"; item = "core"; value = "unlimited"; }
  ];

  boot.kernel.sysctl = {
    # Enable core dumps even for setuid processes
    "fs.suid_dumpable" = 1;
  };
}
