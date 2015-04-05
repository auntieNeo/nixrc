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

        [softphones]
        include => tests

        [unauthenticated]
      '';
    };
  };
}
