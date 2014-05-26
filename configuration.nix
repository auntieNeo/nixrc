# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # See console messages during early boot.
  boot.initrd.kernelModules = [ "fbcon" ];

  # Disable console blanking after being idle.
  boot.kernelParams = [ "consoleblank=0" ];

  networking.hostName = "hakase"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless.

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
    anki
#    anthy  # TODO: write an anthy package (with ibus)
    chromium
    cmake
    conky
    dmenu
    evince
    git
    gutenprint
    irssi
    linuxPackages.virtualbox
    mercurial
    mplayer
    pmutils
    rxvt_unicode
    scons
    screen
    subversionClient
    sudo
    texLiveFull
    tmux
#    typespeed  # TODO: write a typespeed package
    vagrant
    valgrind
    vim
    wget
    xlibs.xinit
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "dvorak";
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver.synaptics.enable = true;

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
    # Configure various dotfiles
    auntieneoDotfiles = ''
      ln -fs ${./dotfiles/tmux.conf} /home/auntieneo/.tmux.conf
      ln -fs ${./dotfiles/vimrc} /home/auntieneo/.vimrc
    '';

    # Configure wireless networks
    wpa_supplicant = ''  # FIXME: does this name have potential for conflict? must investigate
      ln -fs ${./private/etc/wpa_supplicant.conf} /etc/wpa_supplicant.conf
    '';
  };

  # Show the NixOS manual in a virtual console
  services.nixosManual.showManual = true;

# TODO: patch and install dwm
# TODO: patch and install rxvt-unicode with shadows
# TODO: make a package for ansible
# TODO: write an anthy package
# TODO: xset r rate 400 once and for all
# TODO: disable capslock
# TODO: disable annoying ctrl+s flow control
# TODO: install aspell
# TODO: install, configure, and sync unison
# TODO: fix white-out problem with idle screen
# TODO: disable suspend on closed lid
# TODO: configure multiple monitors (depending on which host)
# TODO: configure backgrounds (depending on which host)
# TODO: only configure wireless on systems that need it
# TODO: disable beep
# TODO: figure out how to organize configuration files
# TODO: install ssh keys
# TODO: configure ssh-agent
# TODO: configure cmus
# TODO: configure audio (don't break on reboot, change depending on the host)
}
