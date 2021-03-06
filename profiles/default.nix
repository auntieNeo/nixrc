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
    bridge-utils
    ctags
    expect
    fuse
    git
    gnumake
    gnupg
    idutils
    inetutils
    irssi
    ledger
    links2
#    mailutils
#    heirloom-mailx  # FIXME
    manpages
    mkpasswd
    mosh
    most
    ncurses
#    nkf  # TODO: write a package for Network Kanji Filter
    nix-prefetch-scripts
    p7zip
#    pacman  # TODO: write a package for Arch Linux's pacman (for creating Arch chroots)
    pciutils
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
    usbutils
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
}
