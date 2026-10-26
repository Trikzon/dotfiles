{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/hd60s.nix
    ../../modules/nixos/home-manager.nix
    ../../modules/nixos/network.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/steam.nix
    ../../users/dion.nix
  ];

  networking.hostName = "explorer";

  # Root is LVM-on-LUKS on the NVMe drive.
  boot.initrd.luks.devices.cryptroot = {
    device = "/dev/disk/by-uuid/91689ae9-892b-4e69-8907-a5d2e4d5eae5";
    preLVM = true;
    allowDiscards = true;
  };
  boot.resumeDevice = "/dev/mapper/vgroot-swap";

  # Stage 1 is systemd-based since 26.05 and gives up on devices after 90s,
  # which includes the time spent typing the LUKS passphrase. With LVM on top
  # of LUKS the release notes recommend disabling the timeout for /.
  fileSystems."/".options = [ "x-systemd.device-timeout=infinity" ];

  # Load amdgpu in the initrd so plymouth and the LUKS prompt run at native
  # resolution instead of the firmware framebuffer.
  hardware.amdgpu.initrd.enable = true;

  # Shared data drive. Everyone in the storage group can read/write. The
  # permissions live on the filesystem itself and were set once by hand:
  #   chgrp -R storage /mnt/storage && chmod -R g+rwX /mnt/storage
  #   find /mnt/storage -type d -exec chmod g+s {} +
  #   setfacl -R -m g:storage:rwX -m d:g:storage:rwX /mnt/storage
  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-uuid/7119ed62-ffcd-4d3d-9759-535b28119e37";
    fsType = "ext4";
    options = [ "nofail" ];
  };
  users.groups.storage = { };
  users.users.dion.extraGroups = [ "storage" ];

  # First NixOS release installed on this machine. Never change it; it is not
  # the version you are running. See `man configuration.nix`.
  system.stateVersion = "26.05";
}
