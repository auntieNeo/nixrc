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
    ekiga
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
        rev = "refs/heads/bla";
# r!printf '    sha256 = "\%s";' `nix-prefetch-git file:///home/auntieneo/code/asterisk/asterisk-gerrit --rev refs/heads/bla 2>&/dev/null | tail -n1`
        sha256 = "9924b1e6868ab4de3d4865f8aafdd7a446e8653139868611f45b3c164ded7424";
      };

      buildInputs = [ pkgs.pjsip ] ++ attrs.buildInputs;

      preConfigure = ''
        ln -s ${attrs.coreSounds} sounds/asterisk-core-sounds-en-gsm-1.4.26.tar.gz
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
        context=line1
        defaultuser=fluttershy
        secret=Vekaknobma

        [larry](softphone)
        context=line1
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
    allowedTCPPorts = [
      5060  # SIP
    ];
    allowedUDPPorts = [
      5060  # SIP
    ];
    allowedUDPPortRanges = [
      # default Asterisk RTP port range
      { from = 5000; to = 31000; }
    ];
  };
}
