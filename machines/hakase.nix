
{ config, pkgs, ... }:

{
  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
