{ config, pkgs, ... }:

{
  services.asterisk = {
    otherConfig =
    {
      "extensions.conf" = ''
        [tests]
        exten => 101,1,Answer()
        same  =>     n,Echo()
        same  =>     n,Hangup()

        exten => 100,1,Answer()
        same  =>     n,Wait(1)
        same  =>     n,Playback(hello-world)
        same  =>     n,Hangup()

        exten => 003,1,Answer
        same  =>     n,Wait(5)
        same  =>     n,Festival('You are a butt a butt a butt a butt. You are a butt. Goodbye.')

        [softphones]
        include => tests

        [unauthenticated]
      '';
      "festival.conf" = ''
        [general]
        host=localhost
        port=1314
        festivalcommand=(tts_textasterisk "%s" 'file)(quit)\n
      '';
    };
  };
}
