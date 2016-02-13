{ config, lib, pkgs, ... }:

{
  # KVM support for VGA passthrough
  # See: https://bbs.archlinux.org/viewtopic.php?id=162768

  environment.systemPackages = with pkgs; [
    virtmanager
    qemu
#    (lib.overrideDerivation pkgs.qemu (attrs: {
#      name = "qemu-git";
#      src = pkgs.fetchgit {
#        url = "git://git.qemu.org/qemu.git";
#        rev = "d2966f804d70a244f5dde395fc5d22a50ed3e74e";
#        sha256 = "0e214132e5b11f24dc417de6c76fa3f9005802f13ea3e5c8444c19c9364eda81";
#      };
#    }))
  ];

  virtualisation.libvirtd = {
    enable = true;
    onShutdown = "shutdown";
    extraConfig = ''
      cgroup_device_acl = [
        "/dev/vfio/1",
        "/dev/vfio/12"
      ]
    '';
  };

  boot.kernelModules = [
    "vfio"
    "vfio_pci"
    "vfio_iommu_type1"
  ];

  boot.kernelParams = [
    "intel_iommu=on"
    "vfio_iommu_type1.allow_unsafe_interrupts=1"
    "kvm.allow_unsafe_assigned_interrupts=1"
    "kvm.ignore_msrs=1" # This prevents certain (BSOD) crashes in Windows guests.
#    "i915.enable_hd_vgaarb=1"
    "hugepages=4096"
  ];

  boot.blacklistedKernelModules = [
    "fglrx" "noveau" "nvidia" "radeon"
    "snd_hda_intel"
    "xhci_hcd"  # USB 3.0
  ];

  security.pam.loginLimits = [
    # Allow us to lock a lot of memory
    { domain = "*"; type = "-"; item = "memlock"; value = "unlimited"; }
  ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    # Need latest virt-manager for UEFI boot
#    virtmanager = pkgs.callPackage ../pkgs/virt-manager/default.nix {
#      inherit (pkgs.gnome) gnome_python;
#      vte = pkgs.gnome3.vte;
#      dconf = pkgs.gnome3.dconf;
#      gtkvnc = pkgs.gtkvnc.override { enableGTK3 = true; };
#      spice_gtk = pkgs.spice_gtk.override { enableGTK3 = true; };
#    };
  };
}
