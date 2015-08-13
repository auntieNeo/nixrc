{ config, pkgs, ... }:

{
  services.asterisk = {
    confFiles =
    {
      "bla.conf" = ''
        [line1]
        type=trunk
        device=Local/faux@line1_outbound
        internal_sample_rate=8000
        mixing_interval=80
         
        [line2]
        type=trunk
        device=Local/faux@line2_outbound
         
        [line3]
        type=trunk
        device=Local/faux@line3_outbound
         
        [station](!)
        type=station
        trunk=line1
        trunk=line2
        trunk=line3
         
        [station1line1]
        type=station
        trunk=line1
        device=SIP/polycom1_line1
;        autocontext=bla_stations

        [station1line2]
        type=station
        trunk=line2
        device=SIP/polycom1_line2
;        autocontext=bla_stations
         
        [station1line3]
        type=station
        trunk=line3
        device=SIP/polycom1_line3
;        autocontext=bla_stations
         
        [station2line1]
        type=station
        trunk=line1
        device=SIP/polycom2_line1
;        autocontext=bla_stations

        [station2line2]
        type=station
        trunk=line2
        device=SIP/polycom2_line2
;        autocontext=bla_stations
         
        [station2line3]
        type=station
        trunk=line3
        device=SIP/polycom2_line3
;        autocontext=bla_stations

        [station3](station)
        type=station
        trunk=line1
        trunk=line1
        trunk=line1
        trunk=line1
        trunk=line1
        trunk=line1
        trunk=line1
        device=SIP/fluttershy
;        autocontext=bla_stations
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
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
        same  =>      n(hello),Playback(hello-world)
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

        [bla_stations]
        exten => station1,1,NoOp()
        same  =>          n,BLAStation(station1)
        exten => station1_line1,hint,BLA:station1_line1
        exten => station1_line1,1,BLAStation(station1,line1)
        exten => station1_line2,hint,BLA:station1_line2
        exten => station1_line2,1,BLAStation(station1,line2)
        exten => station2,1,NoOp()
        same  =>          n,BLAStation(station2)
        exten => station2_line1,hint,BLA:station2_line1
        exten => station2_line1,1,BLAStation(station2,line1)
        exten => station2_line2,hint,BLA:station2_line2
        exten => station2_line2,1,BLAStation(station2,line2)
        exten => station3,1,BLAStation(station3)
        exten => station3_line1,hint,BLA:station3_line1
        exten => station3_line1,1,BLAStation(station3,line1)
        exten => station3_line2,hint,BLA:station3_line2
        exten => station3_line2,1,BLAStation(station3,line2)

        [softphones]
        include => bla_stations
        include => line1
        include => line2
        include => line3

        [deskphones]
        include => bla_stations
      '';
    };
  };
}
