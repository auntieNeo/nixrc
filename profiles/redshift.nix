{ config, pkgs, ... }:

{
  services.redshift = {
    enable = false;
    latitude = "42.871303";
    longitude = "-112.445534";
    temperature.night = 4000;
    brightness.night = "0.8";
  };
}
