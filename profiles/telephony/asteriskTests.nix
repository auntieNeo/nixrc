{ config, pkgs, ... }:

{
  services.asterisk = {
    confFiles =
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

        [deskphones]
        include => tests

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
