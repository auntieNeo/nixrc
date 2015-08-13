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
;        autocontext=line1
        ; default user profile and bridge profile
         
        [line2]
        type=trunk
        device=Local/faux@line2_outbound
;        autocontext=line2

;        [line3]
;        type=trunk
;        device=Local/faux@line3_outbound
;        autocontext=line3
;
;        [line4]
;        type=trunk
;        device=Local/faux@line4_outbound
;        autocontext=line4
;         
;        [station](!)
;        type=station
;        trunk=line1
;        trunk=line2
;        trunk=line3
;        trunk=line4
;        autocontext=bla_stations

        [station1line1]
        type=station
        trunk=line1
        trunk=line2
        device=SIP/polycom1_line1
;        autocontext=bla_stations

;        [station1line2]
;        type=station
;        trunk=line2
;        device=SIP/polycom1_line2
;        autocontext=bla_stations
;
;        [station1line3]
;        type=station
;        trunk=line3
;        device=SIP/polycom1_line3
;        autocontext=bla_stations
;
;        [station2line1]
;        type=station
;        trunk=line1
;        device=SIP/polycom2_line1
;        autocontext=bla_stations
;
;        [station2line2]
;        type=station
;        trunk=line2
;        device=SIP/polycom2_line2
;        autocontext=bla_stations
;
;        [station2line3]
;        type=station
;        trunk=line3
;        device=SIP/polycom2_line3
;        autocontext=bla_stations
;         
;        [station3](station)
;        device=SIP/hakase
;         
;        [station4](station)
;        device=SIP/fluttershy
;         
;;        [station5](station)
;;        device=SIP/larry
;
;        [station6](station)
;        device=SIP/sipp
;
;;        [station7](station)
;;        device=Local/answer_everything@station_inbound
      '';
      "confbridge.conf" = ''
        [general]

;        [default_bla_station_user]
;        type=user
;        marked=yes
;        quiet=yes
;        dtmf_passthrough=yes

;        [default_bla_trunk_user]
;        type=user
;        quiet=yes
;        dtmf_passthrough=yes
;        end_marked=yes

;        [default_bla_bridge]
;        type=bridge
;        sound_join=hello-world
      '';
      "extensions.conf" = ''
        [line1]
        exten => 123,1,BLATrunk(line1)

        [line2]
        exten => 456,1,BLATrunk(line2)

        [line3]
        exten => 789,1,BLATrunk(line3)

        [line1_outbound]
        exten => faux,1,NoOp()
        same  =>      n,Wait(1)
        same  =>      n,Answer()
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Wait(90000)
        same  =>      n,Hangup()

        [line2_outbound]
        exten => faux,1,NoOp()
        same  =>      n,Wait(1)
        same  =>      n,Answer()
        same  =>      n,Echo()
        same  =>      n,Hangup()

        [line3_outbound]
        exten => faux,1,NoOp()
        same  =>      n,Wait(1)
        same  =>      n,Answer()
        same  =>      n,Read(DIGITS,,3)
        same  =>      n,SayDigits(''${DIGITS})
        same  =>      n,Hangup()

        [line4_outbound]
        exten => faux,1,NoOp()
        same  =>      n,Wait(1)
        same  =>      n,Answer()
        same  =>      n,Read(DIGITS,,4)
        same  =>      n,GotoIf($[''${DIGITS} = 1234]?line1_outbound,faux,1)
        same  =>      n,Hangup()

        [station_inbound]
        exten => answer_everything,1,NoOp()
        same  =>      n,Wait(3)
        same  =>      n,Answer()
        same  =>      n,Wait(1)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Playback(hello-world)
        same  =>      n,Hangup()

        [inbound]
        exten => 100,1,Goto(line1,100,1)
        exten => 200,1,Goto(line2,200,1)

        [deskphones]
        include => bla_stations

        [softphones]
        include => bla_stations
        include => line1
        include => line2
        include => line3
      '';
    };
  };
}

