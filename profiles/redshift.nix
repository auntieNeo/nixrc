{ config, pkgs, ... }:

{
  services.redshift = {
    enable = true;
    latitude = "42.871303";
    longitude = "-112.445534";
    temperature.night = 3500;
    brightness.night = "0.4";
  };
}
