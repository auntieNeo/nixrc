{ config, lib, pkgs, ... }:

{
  imports = [
#    ../services/asterisk.nix

    # Various Asterisk configurations (enable only one at a time)
#    ./telephony/asteriskTests.nix
#    ./telephony/confBridgeSLA.nix
#    ./telephony/BLA.nix
    ./telephony/BLA_autocontext.nix
#    ./telephony/confBridge.nix
  ];

  environment.systemPackages = with pkgs; [
    asterisk
#    asterisk-testsuite
    blink
#    ekiga  # FIXME
    empathy
    festival
    jitsi
    sipp
#    srtp_linphone
    (pkgs.misc.debugVersion twinkle)
  ];

  # custom packages
  nixpkgs.config.packageOverrides = pkgs: rec {
#    asterisk-orig = pkgs.callPackage ../pkgs/asterisk/default.nix { };
    asterisk = pkgs.misc.debugVersion (lib.overrideDerivation pkgs.asterisk (attrs: rec {
      name = "asterisk-git";
      src = pkgs.fetchgit {
        url = file:///home/auntieneo/code/asterisk/asterisk-gerrit;
        rev = "refs/heads/app_bla";
# r!printf '    sha256 = "\%s";' `nix-prefetch-git file:///home/auntieneo/code/asterisk/asterisk-gerrit --rev refs/heads/app_bla 2>&/dev/null | tail -n1`
        sha256 = "6417fdbb15704ba8ee2d49c0ad1288d32f8e9c00f4f34223e4b5895decf13bcf";
      };

      buildInputs = [ pkgs.pjsip ] ++ attrs.buildInputs;

      coreSounds = pkgs.fetchurl {
        url = http://downloads.asterisk.org/pub/telephony/sounds/releases/asterisk-core-sounds-en-gsm-1.4.27.tar.gz;
        sha256 = "1z8hb0511vnp3cbryblj0paqnm41dqz5b8vi789v8lgd7jmhd95s";
      };

      preConfigure = ''
        ln -s ${coreSounds} sounds/asterisk-core-sounds-en-gsm-1.4.27.tar.gz
        ln -s ${attrs.mohSounds} sounds/asterisk-moh-opsound-wav-2.03.tar.gz

        # FIXME: This is a hack. I have no idea why the gcc wrapper fails to add pjsip to the include path. Maybe a bug with packageOverrides?
        export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE -isystem ${pkgs.pjsip}/include/"
      '';

#      configureFlags = "${attrs.configureFlags} --enable-dev-mode";
    }));
    asterisk-testsuite-orig = pkgs.callPackage ../pkgs/asterisk-testsuite/default.nix { };
    asterisk-testsuite = pkgs.misc.debugVersion (lib.overrideDerivation asterisk-testsuite-orig (attrs: rec {
      name = "asterisk-testsuite-git";
      src = pkgs.fetchgit {
        url = file:///home/auntieneo/code/asterisk/testsuite;
        rev = "refs/heads/master";
        sha256 = "65d522c5f6e73bebf8ddd239e95811717cd944955c2052e3080bdaefa2994590";
      };
    }));
#    sipp = pkgs.callPackage ../pkgs/sipp/default.nix { };
    speech_tools = pkgs.callPackage ../pkgs/speech_tools/default.nix { };
    festival = pkgs.callPackage ../pkgs/festival/default.nix { };
  };

  services.asterisk = {
    enable = true;
    extraConfig = ''
      [options]
      verbose=10
      debug=10
    '';
    confFiles = {
      "logger.conf" = ''
        [general]

        [logfiles]
        full => notice,warning,error,debug,verbose
        syslog.local0 => notice,warning,error,debug,verbose
      '';
      "sip.conf" = ''
        [general]
        context=unauthenticated
        allowguest=no
        srvlookup=no  ; Don't do DNS lookup
        udpbindaddr=0.0.0.0  ; Listen on all interfaces
        tcpenable=no
        nat=force_rport,comedia  ; Assume device is behind NAT
        callcounter=yes
        insecure=port,invite

        [deskphone](!)
        type=friend  ; Channel driver matches on username first, IP second
        context=deskphones
        host=dynamic  ; Device will register with asterisk
        disallow=all
        allow=g722
        allow=ulaw
        allow=alaw

        [polycom1_line1](deskphone)
        secret=pyfliptoik

        [polycom1_line2](deskphone)
        secret=pyfliptoik

        [polycom1_line3](deskphone)
        secret=pyfliptoik

        [polycom2_line1](deskphone)
        secret=pipjuHoded

        [polycom2_line2](deskphone)
        secret=pipjuHoded

        [polycom2_line3](deskphone)
        secret=pipjuHoded

        [softphone](!)
        type=friend  ; Channel driver matches on username first, IP second
        context=softphones
        host=dynamic  ; Device will register with asterisk
        disallow=all
        allow=g722
        allow=ulaw
        allow=alaw

        [hakase](softphone)
        defaultuser=hakase
        defaultip=127.0.0.1
        secret=GhoshevFew

        [fluttershy](softphone)
;        context=line1
        defaultuser=fluttershy
        secret=Vekaknobma

        [larry](softphone)
;        context=line1
;        context=inbound
        defaultuser=larry
        secret=shivKujSie

        [sipp](softphone)
;        context=line1
;        context=inbound
        defaultuser=sipp
        host=127.0.0.1
        secret=CytMyQuog2
      '';
      "iax.conf" = ''
        [general]
        context=unauthenticated
        allowguest=no
        srvlookup=no  ; Don't do DNS lookup
        udpbindaddr=0.0.0.0  ; Listen on all interfaces
        tcpenable=no
      '';
    };
  };

  # Allow telephony ports
  networking.firewall = {
    enable = true;
#    # FIXME: I can't seem to get TFTP connection tracking to work
#    trustedInterfaces = [ "enp3s0" ];
    allowedTCPPorts = [
      5060  # SIP
    ];
    allowedUDPPorts = [
      69  # TFTP
      5060  # SIP
    ];
    allowedUDPPortRanges = [
      # default Asterisk RTP port range
      { from = 5000; to = 31000; }
    ];
    autoLoadConntrackHelpers = true;
    connectionTrackingModules = [ "tftp" ];
    extraCommands = ''
      iptables -A OUTPUT -p udp --sport 69 -m state --state ESTABLISHED -j ACCEPT
    '';
  };

  # Serve configuration files for deskphones
  services.tftpd = rec {
    enable = true;
    path = "${./telephony/deskphone_config}";
#    path =
#    let
#      files = {
#        "phone1.cfg" = ''
#          something
#        '';
#      };
#    in
#    pkgs.stdenv.mkDerivation
#    ((lib.mapAttrs' (name: value: lib.nameValuePair
#            # Fudge the file names to make bash happy
#            ((lib.replaceChars ["."] ["_"] name) + "_")
#            (value)
#          ) files) //
#
#    {
#      name = "deskphone-config";
#
#      filesString = lib.concatStringsSep " " (
#        lib.attrNames files
#      );
#
#      buildCommand =
#      ''
#        mkdir -p "$out"
#        for i in $filesString; do
#          file=$(echo "$i"_ | sed 's/\./_/g')
#          echo "''${!file}" > "$out"/"$i"
#        done
#      '';
#    });
  };
}
