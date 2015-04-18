{ config, pkgs, ... }:

{
  services.asterisk = {
    confFiles =
    {
      "modules.conf" = ''
        [modules]
        autoload = yes

        load => bridge_builtin_features.so
        load => res_timing_timerfd.so
        load => app_confbridge.so
        load => chan_sip.so
      '';
      "bla.conf" = ''
        [line1]
        type=trunk
        device=Local/faux@line1_outbound
        autocontext=line1
        ; default user profile and bridge profile
         
        [line2]
        type=trunk
        device=Local/faux@line2_outbound
        autocontext=line2
        trunk_user_profile=incoming_user  ; default user profile for calls INTO the trunk (i.e. channels that invoke BLATrunk())
        station_user_profile=outgoing_user  ; default user profile for stations
        bridge_profile=trunk_bridge  ; bridge type to mix channels (obviously for all channels on this trunk)
         
        [station](!)
        type=station
        trunk=line1
        trunk=line2
        autocontext=bla_stations
         
        [station1](station)
        device=SIP/hakase
        user_profile=admin_user
         
        [station2](station)
        device=SIP/fluttershy
         
        [station3](station)
        device=SIP/station3
      '';
      "confbridge.conf" = ''
        [general]

        [default_user]
        type=user

        [default_bridge]
        type=bridge

        [incoming_user]
        type=user

        [outgoing_user]
        type=user

        [admin_user]
        type=user

        [trunk_bridge]
        type=bridge
      '';
      "extensions.conf" = ''
        [line1]
        ; FIXME: For some reason, s is needed here. I'm not sure why.
        exten => s,1,BLATrunk(line1)
         
        [line2]
        exten => s,2,BLATrunk(line2)

        [line1_outbound]
        exten => faux,1,NoOp()
        same  =>      n,Wait(1)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n,Hangup()

        [line2_outbound]
        exten => faux,1,NoOp()
        same  =>      n,Wait(1)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n,Hangup()
         
        [bla_stations]
        exten => station1,1,NoOp()
        same  =>          n,Wait(1)
;        same  =>          n(hello),Playback(hello-world)
        same  =>          n,BLAStation(station1)
        exten => station1_line1,hint,BLA:station1_line1
        exten => station1_line1,1,BLAStation(station1_line1)
        exten => station1_line2,hint,BLA:station1_line2
        exten => station1_line2,1,BLAStation(station1_line2)
        exten => station2,1,NoOp()
        same  =>          n,Wait(1)
;        same  =>          n(hello),Playback(hello-world)
        same  =>          n,BLAStation(station2)
        exten => station2_line1,hint,BLA:station2_line1
        exten => station2_line1,1,BLAStation(station2_line1)
        exten => station2_line2,hint,BLA:station2_line2
        exten => station2_line2,1,BLAStation(station2_line2)
        exten => station3,1,BLAStation(station3)
        exten => station3_line1,hint,BLA:station3_line1
        exten => station3_line1,1,BLAStation(station3_line1)
        exten => station3_line2,hint,BLA:station3_line2
        exten => station3_line2,1,BLAStation(station3_line2)

        [bla_tests]
        exten => dial_line1,1,Dial(Local/100@Line1)

        [softphones]
        include => bla_stations
        include => bla_tests
      '';
    };
  };
}
