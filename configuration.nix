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
    anki
#    anthy  # TODO: write an anthy package (with ibus)
    chromium
    cmake
    conky
    ctags
    dmenu
    # install patched version of dwm
    (pkgs.lib.overrideDerivation pkgs.dwm (attrs: {
        name = "dwm-6.0-patched";
        src = fetchurl {
          url = "https://github.com/auntieNeo/dwm/archive/e7d079df7024379b50c520f14f613f0c036153b1.tar.gz";
          sha256 = "5415d2fe5458165253e047df434a7840d5488f8a60487a05c00bb4f38fe4843f";
        };
    }))
    evince
    git
    gutenprint
    irssi
    links2
    linuxPackages.virtualbox
    mercurial
    mplayer
    pmutils
    psmisc
    rxvt_unicode
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
    xlibs.xinit
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
    dotfiles = ''
      ln -fs ${./dotfiles/gitconfig} /home/auntieneo/.gitconfig
      ln -fs ${./dotfiles/tmux.conf} /home/auntieneo/.tmux.conf
      ln -fs ${./dotfiles/vimrc} /home/auntieneo/.vimrc
      ln -fs ${./dotfiles/Xdefaults} /home/auntieneo/.Xdefaults
      ln -fs ${./dotfiles/tmux.conf} /root/.tmux.conf
      ln -fs ${./dotfiles/vimrc} /root/.vimrc
    '';

# FIXME: wpa_supplicant expects the wpa_supplicant.conf file to be in a read/write filesystem. This is a problem.
#    # Configure wireless networks
#    wpa_supplicant = ''  # FIXME: does this name have potential for conflict? must investigate
#      ln -fs ${./private/etc/wpa_supplicant.conf} /etc/wpa_supplicant.conf
#    '';
  };

  # Show the NixOS manual in a virtual console
  services.nixosManual.showManual = true;

# TODO: patch and install rxvt-unicode with shadows
# TODO: make a package for ansible
# TODO: write an anthy package

# TODO: xset r rate 400 once and for all
# TODO: disable capslock
# TODO: enable nib scrollwheel

# TODO: disable annoying ctrl+s flow control
# TODO: configure NIX_PATH with /home/auntieneo/code/nixpkgs

# TODO: disable annoying ctrl+s flow control for root user
# TODO: configure vim for the root user

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
# TODO: configure git email and username

# TODO: configure cmus
# TODO: configure audio (don't break on reboot, change depending on the host)
}
