# Most (all?) hosts defined in this import most of their configuration from
# ./configuration-common.nix, which in turn imports their respective
# ./machine/*.nix file.

let 

  ec2-region = "us-west-2";
  ec2-zone = "us-west-2b";
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
  network.description = "auntieneo.net";

  # Provision an EC2 key pair
  resources.ec2KeyPairs.auntie-key-pair = {
    region = ec2-region;
    accessKeyId = ec2-accessKeyId; };

  # Provision an EC2 volume for persistent storage of /home files
  resources.ebsVolumes.home = {
    name = "/home";
    region = ec2-region;
    zone = ec2-zone;
    accessKeyId = ec2-accessKeyId;  # symbolic name looked up in ~/.ec2-keys
    volumeType = "standard";
    size = 10;
  };

  dhaos =
  { resources, config, pkgs, ... }:
  { 
    # FIXME: move deployment out of here
    deployment = {
      targetEnv = "ec2";
      ec2 = {
        accessKeyId = ec2-accessKeyId;  # symbolic name looked up in ~/.ec2-keys
        region = ec2-region;
        zone = ec2-zone;
        instanceType = "t2.micro";
        ami = "ami-fb9dc3cb";
        keyPair = resources.ec2KeyPairs.auntie-key-pair;
        securityGroups = [ "allow-ssh" ];
        ebsBoot = true;  # only EBS-backed instances can mount EBS volumes at boot
      };
    };
    # map persistent storage for /home
    fileSystems."/home" = {
      fsType = "ext4";
      autoFormat = true;
      device = "/dev/xvdf";
      ec2.disk = resources.ebsVolumes.home;
    };
    # import configuration modules
    imports = [
      ./configuration-common.nix
      ./machines/dhaos.nix
    ];
  };
}
