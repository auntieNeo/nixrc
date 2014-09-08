{ pkgs, ... }:

{
   teensy = pkgs.myEnvFun {
    name = "teensy";
    buildInputs = with pkgs; [
      arduino_core
      avrgcclibc
      teensy-loader
    ];
  };
}
