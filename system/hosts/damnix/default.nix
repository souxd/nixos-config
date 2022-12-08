{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./users.nix
    ../../configuration.nix
    ../../modules/qbittorrent.nix
    ../../modules/desktop/crocus.nix
    ../../modules/desktop/gnome.nix
    ../../modules/drawing.nix
    ../../modules/zerotier.nix
  ];

  networking.hostName = "damnix";
  time.timeZone = "Brazil/East";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "vm.vfs_cache_pressure=500"
      "vm.swappiness=100"
      "vm.dirty_background_ratio=1"
      "vm.dirty_ratio=50"
    ];
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };
  };

  fileSystems = {
    # Enforce fstab options
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/swap".options = [ "noatime" ];
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };
}
