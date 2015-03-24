{ config, lib, pkgs, ... }:

with lib;

{
  options = {
    services.display.sessions.wayland.velox = {
      command = mkOption {
        type = types.str;
        internal = true;
      };
      attr = mkOption {
        internal = true;
        description = "Internal attributes that describe the session type.";
      };
    };
  };

  config = {
    services.display.sessions.wayland.velox = {
      command = "${pkgs.velox}/bin/velox";
      attr = {
        libswc = true;
      };
    };
  };
}
