{ config, pkgs, ... }:

{
  imports = [
    ../services/asterisk.nix

    # Various Asterisk configurations (enable only one at a time)
    ./telephony/asteriskTests.nix
#    ./telephony/confBridgeSLA.nix
#    ./telephony/confBridgeBLA.nix
#    ./telephony/confBridge.nix
  ];

  environment.systemPackages = with pkgs; [
#    asterisk
    (pkgs.lib.overrideDerivation pkgs.asterisk (attrs: rec {
      name = "asterisk-git";
      src = fetchgit {
        url = file:///home/auntieneo/code/asterisk/git;
        rev = "c5d3e54545175dfe727305195478da032f9301ed";
        sha256 = "c189f3592386759ff9a361294d29e6dbe91ba5b0b7d2537937fa20a20da14d70";
      };

      coreSounds = fetchurl {
        url = http://downloads.asterisk.org/pub/telephony/sounds/releases/asterisk-core-sounds-en-gsm-1.4.26.tar.gz;
        sha256 = "2300e3ed1d2ded6808a30a6ba71191e7784710613a5431afebbd0162eb4d5d73";
      };
      mohSounds = fetchurl {
        url = http://downloads.asterisk.org/pub/telephony/sounds/releases/asterisk-moh-opsound-wav-2.03.tar.gz;
        sha256 = "449fb810d16502c3052fedf02f7e77b36206ac5a145f3dacf4177843a2fcb538";
      };

      preConfigure = ''
        ln -s ${coreSounds} sounds/asterisk-core-sounds-en-gsm-1.4.26.tar.gz
        ln -s ${mohSounds} sounds/asterisk-moh-opsound-wav-2.03.tar.gz
      '';
    }))
    blink
    ekiga
    empathy
    jitsi
    sipp
    srtp_linphone
    twinkle
  ];

  # custom packages
  nixpkgs.config.packageOverrides = pkgs: rec {
    asterisk = pkgs.callPackage ../pkgs/asterisk/default.nix { };
    sipp = pkgs.callPackage ../pkgs/sipp/default.nix { };
  };

  services.asterisk = {
    enable = true;
    otherConfig = {
      "sip.conf" = ''
        [general]
        context=unauthenticated
        allowguest=no
        srvlookup=no  ; Don't do DNS lookup
        udpbindaddr=0.0.0.0  ; Listen on all interfaces
        tcpenable=no
        nat=force_rport,comedia  ; Assume device is behind NAT

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
        secret=GhoshevFew

        [fluttershy](softphone)
        defaultuser=fluttershy
        secret=Vekaknobma
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
