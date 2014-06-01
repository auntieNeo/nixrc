# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

rec {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Import machine-specific configuration files.
      (./machines + "/${builtins.readFile ./hostname}.nix")  # FIXME: this breaks when ./hostname has a newline at the end
    ];

  # Allow proprietary software (such as the NVIDIA drivers).
  nixpkgs.config.allowUnfree = true;

  # See console messages during early boot.
  boot.initrd.kernelModules = [ "fbcon" ];

  # Disable console blanking after being idle.
  boot.kernelParams = [ "consoleblank=0" ];

  # Set the hostname from the contents of ./hostname
  networking.hostName = builtins.readFile ./hostname;  # FIXME: this breaks when ./hostname has a newline at the end

  # Google nameservers
  networking.nameservers = [
    "8.8.8.8"
    "8.8.4.4"
  ];

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  # Set the timezone.
  time.timeZone = "US/Mountain";

  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
#    ansible  # TODO: write an ansible package
    apg
    aspell
    aspellDicts.en
    cmake
    ctags
    git
    irssi
    links2
    linuxPackages.virtualbox
    manpages
    mercurial
    ncurses
    pmutils
    psmisc
    rtorrent
    rxvt_unicode
    pmutils
    psmisc
    scons
    screen
    stdenv
    subversionClient
    sudo
    texLiveFull
    tmux
#    typespeed  # TODO: write a typespeed package
    vagrant
    valgrind
    vim
    wget
    wgetpaste
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.auntieneo = {
    name = "auntieneo";
    group = "users";
    extraGroups = [ "wheel" ];
    uid = 1000;
    createHome = true;
    home = "/home/auntieneo";
    shell = "/run/current-system/sw/bin/bash";
  };

  system.activationScripts =
  {
    # Configure various dotfiles.
    dotfiles = ''
      ln -fs ${./dotfiles/bashrc} /home/auntieneo/.bashrc
      ln -fs ${./dotfiles/gitconfig} /home/auntieneo/.gitconfig
      ln -fs ${./dotfiles/tmux.conf} /home/auntieneo/.tmux.conf
      ln -fs ${./dotfiles/vimrc} /home/auntieneo/.vimrc
      ln -fs ${./dotfiles/Xdefaults} /home/auntieneo/.Xdefaults
      ln -fs ${./dotfiles/bashrc} /root/.bashrc
      ln -fs ${./dotfiles/tmux.conf} /root/.tmux.conf
      ln -fs ${./dotfiles/vimrc} /root/.vimrc
    '';

# FIXME: wpa_supplicant expects the wpa_supplicant.conf file to be in a read/write filesystem. This is a problem.
#    # Configure wireless networks
#    wpa_supplicant = ''  # FIXME: does this name have potential for conflict? must investigate
#      ln -fs ${./private/etc/wpa_supplicant.conf} /etc/wpa_supplicant.conf
#    '';
  };

  # Show the NixOS manual in a virtual console.
  services.nixosManual.showManual = true;

# TODO: patch and install rxvt-unicode with shadows
# TODO: make a package for ansible
# TODO: write an anthy package

# TODO: try to load ./Session.vim whenever "vim" is run
# TODO: write macro to set function keys to run commands
# FIXME: vim ctrl+h ctrl+s tab navigation seems to be broken on my netbook

# TODO: xset r rate 400 once and for all
# TODO: enable nib scrollwheel

# TODO: configure NIX_PATH with /home/auntieneo/code/nixpkgs
# TODO: configure zsh to behave like bash but still be awesome
# TODO: set EDITOR to vim

# TODO: use wmname to set the window manager name to LG3D (hack to get Java to behave in dwm)

# TODO: install, configure, and sync unison
# TODO: fix white-out problem with idle screen
# TODO: disable suspend on closed lid
# TODO: configure multiple monitors (depending on which host)
# TODO: configure backgrounds (depending on which host)
# TODO: only configure wireless on systems that need it
# TODO: disable beep
# TODO: configure ntp
# TODO: figure out how to organize configuration files

# TODO: install ssh keys
# TODO: configure ssh-agent
# TODO: configure git email and username

# TODO: configure cmus
# TODO: configure audio (don't break on reboot, change depending on the host)
# TODO: configure irssi
# TODO: automatically start and configure tmux (different for each machine)
}
