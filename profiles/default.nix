{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
#    ansible
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
    manpages
    mkpasswd
    ncurses
#    nkf  # TODO: write a package for Network Kanji Filter
    nix-prefetch-scripts
#    pacman  # TODO: write a package for Arch Linux's pacman (for creating Arch chroots)
    pmutils
    psmisc
    rtorrent
    screen
    stdenv
    sudo
    tcpdump
    tmux
#    rubyLibs.tmuxinator
    unison
    unzip
    vim_configurable
    vlock
    wget
    wgetpaste
    zsh
  ];

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
