{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
#    mysqlWorkbench
#    qtspim  # FIXME
#    octaveFull
  ];

#  services.postgresql = {
#    enable = false;
#  };
#  services.mysql = {
#    enable = true;
#    package = pkgs.mysql55;
#  };
#  services.httpd = {
#    enable = true;
#    adminAddr = "glinjona@isu.edu";
#    enableUserDir = true;
#      #LoadModule perl_module ${pkgs.perlPackages.mod_perl2}/lib/perl5/site_perl/5.20.3/x86_64-linux-thread-multi/mod_perl2.pm
#    extraConfig = ''
#      <Location /~auntieneo>
#        AddHandler cgi-script .pl
#        Options +ExecCGI
#
##        SetHandler perl-script
##        PerlResponseHandler ModPerl::Registry
##        PerlOptions +ParseHeaders
#
#        Order allow,deny
#        Allow from all 
#      </Location>
#    '';
##    servedDirs = [{
###      dir = "/home/auntieneo/school/spring2016/databases/project/deliverable2";
##      dir = "/tmp/test";
##      urlPath = "/test";
##    }];
#  };

#  nixpkgs.config.packageOverrides = pkgs: rec {
#    qtspim = pkgs.callPackage ../pkgs/qtspim/default.nix {};
#  };
}
