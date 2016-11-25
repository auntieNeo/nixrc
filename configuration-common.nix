# Most of the configuration is in here. This configuration is common to both
# conventional NixOS installs (see nixos-install) and NixOS installed by
# Nixops. For configuration specific to conventional installs and Nixops
# installs, see ./configuration.nix and ./nixops.nix respectively.

{ config, lib, pkgs, ... }:

with lib;
rec {
  imports = [
    # Import default packages.
    ./profiles/default.nix
  ];

  # Allow proprietary software (such as the NVIDIA drivers).
  nixpkgs.config.allowUnfree = true;

#  nix.package = pkgs.nixUnstable;

  boot = {
    # See console messages during early boot.
    initrd.kernelModules = [ "fbcon" ];

    # Disable console blanking after being idle.
    kernelParams = [ "consoleblank=0" ];
  };

#  networking.hostName = "${config.hostName}";

#  # Google nameservers
#  networking.nameservers = [
#    "8.8.8.8"
#    "8.8.4.4"
#  ];

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  # Set the timezone.
  time.timeZone = "US/Mountain";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.auntieneo = {
    name = "auntieneo";
    group = "auntieneo";
    extraGroups = [
      "audio"
      "libvirtd"
      "networkmanager"
      "users"
      "vboxusers"
      "video"
      "weston-launch"
      "wheel"
    ];
    uid = 1000;
    # FIXME: createHome doesn't run early enough for a freshly created /home disk
    # (i.e. user is left without a home directory)
    createHome = true;
    home = "/home/auntieneo";
    shell = "/run/current-system/sw/bin/zsh";
  };
  users.extraGroups.auntieneo.gid = 1000;

  system.activationScripts =
  {
    # Configure various dotfiles.
    dotfiles = stringAfter [ "users" ]
    ''
      cd /home/auntieneo
      ln -fs ${./dotfiles/aliases} .aliases
      ln -fs ${./dotfiles/bash_profile} .bash_profile
      ln -fs ${./dotfiles/bashrc} .bashrc
      ln -fsn ${./dotfiles/bin} .bin
      ln -fs ${./dotfiles/common} .common
      ln -fs ${./dotfiles/gitconfig} .gitconfig
      ln -fs ${./dotfiles/grconfig.json} .grconfig.json
      ln -fsn ${./dotfiles/irssi} .irssi  # FIXME: as this directory is read-only, irssi can't write logs and such
      if [ ! -e .mailrc ]; then
        # FIXME: Change this when I figure out how to better store secrets
        cp ${./dotfiles/mailrc} .mailrc
        chmod 0700 .mailrc
        chown auntieneo:auntieneo .mailrc
      fi
      mkdir .nixpkgs 2>/dev/null || true
      chown auntieneo:auntieneo .nixpkgs
      ln -fs ${./dotfiles/nixpkgs/config.nix} .nixpkgs/config.nix  # FIXME: create a directory for nixpkgs
      ln -fsn ${./dotfiles/oh-my-zsh} .oh-my-zsh
      ln -fs ${./dotfiles/pwclientrc} .pwclientrc
#      cp ${./dotfiles/pwclientrc} .pwclientrc
#      chown auntieneo:auntieneo .pwclientrc
#      chmod 0644 .pwclientrc
      mkdir --mode=0700 .ssh 2>/dev/null || true
      chown auntieneo:auntieneo .ssh
      cp ${./dotfiles/ssh/authorized_keys} .ssh/authorized_keys
      mkdir --mode=0600 .ssh/authorized_keys 2>/dev/null || true
      chown auntieneo:auntieneo .ssh/authorized_keys
      ln -fs ${./dotfiles/ssh/config} .ssh/config  # FIXME: create the .ssh directory
      ln -fs ${./dotfiles/tmux.conf} .tmux.conf
      ln -fsn ${./dotfiles/tmuxinator} .tmuxinator
      mkdir .unison 2>/dev/null || true
      chown auntieneo:auntieneo .unison
      ln -fs ${./dotfiles/unison/common.prf} .unison/common.prf  # FIXME: create a directory for unison
      ln -fs ${./dotfiles/unison/default.prf} .unison/default.prf
      ln -fs ${./dotfiles/velox.conf} .velox.conf
      ln -fs ${./dotfiles/vimlatex} .vimlatex
      ln -fs ${./dotfiles/vimnotepad} .vimnotepad
      ln -fs ${./dotfiles/vimpython} .vimpython
      ln -fs ${./dotfiles/vimtabs} .vimtabs
      ln -fs ${./dotfiles/vimrc} .vimrc
      ln -fs ${./dotfiles/Xdefaults} .Xdefaults
      ln -fs ${./dotfiles/ycm_extra_conf.py} .ycm_extra_conf.py
      ln -fs ${./dotfiles/zshrc} .zshrc

      ln -fs ${./dotfiles/bash_profile} /root/.bash_profile
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

  # Disable the infamous systemd screen/tmux killer
  services.logind.extraConfig = ''
    KillUserProcesses=no
  '';

# TODO: write an anthy package
# TODO: update vagrant to at lesat version 1.6 (for Windows guest support)
# TODO: write packages for some repository management tools, such as myrepo, gr, Android's repo, and mu-repo

# TODO: try to load ./Session.vim whenever "vim" is run (probably using myFunEnv or something)
# TODO: write macro to set function keys to run commands
# TODO: add ctrl+<left> and ctrl+<right> tab navigation in vim (for use from my phone)
# TODO: configure YouCompleteMe vim plugin

# TODO: configure zsh to behave like bash but still be awesome
# TODO: setopt NO_HUP to keep background jobs alive when zsh exits

# TODO: use wmname to set the window manager name to LG3D (hack to get Java to behave in dwm)
# TODO: configure clickable URLs in rxvt-unicode (see https://wiki.archlinux.org/index.php/rxvt-unicode#Clickable_URLs)
# TODO: patch to enable splitting the primary tile in dwm
# TODO: patch dwm to ALWAYS be able to change the volume (or find some other solution)

# TODO: install, configure, and sync unison
# TODO: fix white-out problem with idle screen
# TODO: disable suspend on closed lid
# TODO: configure multiple monitors (depending on which host)
# TODO: configure backgrounds (depending on which host)
# TODO: only configure wireless on systems that need it

# TODO: install ssh keys
# TODO: configure ssh-agent
# TODO: configure git email and username
# TODO: make reverse proxy ssh service

# TODO: configure cmus
# TODO: configure audio (don't break on reboot, change depending on the host)
# TODO: automatically start and configure tmux (different for each machine)
# TODO: automatically import Chromium settings (probably through Google profile)

# TODO: configure Android USB tethering
}
