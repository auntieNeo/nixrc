{ config, pkgs, ... }:

{
  services.asterisk = {
    otherConfig =
    {
      "extensions.conf" = ''
        [ConferenceRooms]
        exten => 602,1,NoOp()
        same =>      n,ConfBridge(''${EXTEN})

        [softphones]
        include => ConferenceRooms

        [unauthenticated]
      '';
      "confbridge.conf" = ''
        [general]

        [default_user]
        type=user

        [default_bridge]
        type=bridge
      '';
    };
  };
}
