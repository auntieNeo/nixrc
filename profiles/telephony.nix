{ config, lib, pkgs, ... }:

{
  imports = [
    ../services/asterisk.nix

    # Various Asterisk configurations (enable only one at a time)
#    ./telephony/asteriskTests.nix
#    ./telephony/confBridgeSLA.nix
    ./telephony/confBridgeBLA.nix
#    ./telephony/confBridge.nix
  ];

  environment.systemPackages = with pkgs; [
    asterisk
    asterisk-testsuite
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
    asterisk-orig = pkgs.callPackage ../pkgs/asterisk/default.nix { };
    asterisk = pkgs.misc.debugVersion (lib.overrideDerivation asterisk-orig (attrs: rec {
      name = "asterisk-git";
      src = pkgs.fetchgit {
        url = file:///home/auntieneo/code/asterisk/git;
        rev = "refs/heads/bla";
# r!printf '    sha256 = "\%s";' `nix-prefetch-git file:///home/auntieneo/code/asterisk/git --rev refs/heads/bla 2>&/dev/null | tail -n1`
        sha256 = "046f19911a2648eab10ce7b8e20bf983581a7a789995ef784d6bc69914f0971f";
      };

      preConfigure = ''
        ln -s ${attrs.coreSounds} sounds/asterisk-core-sounds-en-gsm-1.4.26.tar.gz
        ln -s ${attrs.mohSounds} sounds/asterisk-moh-opsound-wav-2.03.tar.gz
      '';
          })
        );
    asterisk-testsuite = pkgs.callPackage ../pkgs/asterisk-testsuite/default.nix { };
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
        defaultuser=fluttershy
        secret=Vekaknobma

        [sipp](softphone)
        context=line1
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

#  # Asterisk config straight from the example documentation:
#  services.asterisk = {
#    enable = true;
#    extraConfig = ''
#      [options]
#      verbose=3
#      debug=3
#    '';
#    confFiles = {
#      "extensions.conf" = ''
#        [tests]
#        exten => 100,1,Answer()
#        same  =>     n,Wait(1)
#        same  =>     n,Playback(hello-world)
#        same  =>     n,Hangup()
#
#        [softphones]
#        include => tests
#
#        [unauthorized]
#      '';
#      "sip.conf" = ''
#        [general]
#        allowguest=no              ; Require authentication
#        context=unauthorized       ; Send unauthorized users to /dev/null
#        srvlookup=no               ; Don't do DNS lookup
#        udpbindaddr=0.0.0.0        ; Listen on all interfaces
#        nat=force_rport,comedia    ; Assume device is behind NAT
#
#        [softphone](!)
#        type=friend                ; Match on username first, IP second
#        context=softphones         ; Send to softphones context in
#                                   ; extensions.conf file
#        host=dynamic               ; Device will register with asterisk
#        disallow=all               ; Manually specify codecs to allow
#        allow=g722
#        allow=ulaw
#        allow=alaw
#
#        [myphone](softphone)
#        secret=GhoshevFew          ; Change this password!
#      '';
#      "logger.conf" = ''
#        [general]
#
#        [logfiles]
#        syslog.local0 => notice,warning,error,debug
#      '';
#    };
#    extraArguments = [
#      "-vvvddd" "-e" "1024"
#    ];
#  };

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
