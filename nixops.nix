# Most (all?) hosts defined in this import most of their configuration from
# ./configuration-common.nix, which in turn imports their respective
# ./machine/*.nix file.

let 

  ec2-region = "us-west-2";
  ec2-accessKeyId = "auntie";  # symbolic name looked up in ~/.ec2-keys

  ec2-small = 
    { resources, ... }:
    {
      deployment = {
        targetEnv = "ec2";
        ec2 = {
          accessKeyId = ec2-accessKeyId;  # symbolic name looked up in ~/.ec2-keys
          region = ec2-region;
          instanceType = "m2.small";
          keyPair = resources.ec2KeyPairs.auntie-key-pair;
#          securityGroups = [ "allow-ssh" ];
        };
      };
    };

  virtualbox-small = 
    { ... }:
    {
      deployment = {
        targetEnv = "virtualbox";
        virtualbox.memorySize = 1024;  # megabytes
      };
    };

in
{
#  network.description = "dhaos network";

  # Provision an EC2 key pair
  resources.ec2KeyPairs.auntie-key-pair =
  { region = ec2-region;
    accessKeyId = ec2-accessKeyId; };

  dhaos =
  { resources, config, pkgs, ... }:
  { 
    # FIXME: move deployment out of here
    deployment = {
      targetEnv = "ec2";
      ec2 = {
        accessKeyId = ec2-accessKeyId;  # symbolic name looked up in ~/.ec2-keys
        region = ec2-region;
        instanceType = "t2.small";
        ami = "ami-3bf1bf0b";
        keyPair = resources.ec2KeyPairs.auntie-key-pair;
        securityGroups = [ "allow-ssh" ];
      };
    };
    imports = [
      ./configuration-common.nix
      ./machines/dhaos.nix
    ];
  };
}
