{ config, pkgs, pkgs-stable, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/default.nix
      ../../modules/cachix.nix
      ../../modules/locale.nix
      ../../modules/virt-manager.nix
      ../../modules/vlan.nix
      ../../modules/qbittorrent.nix
      ../../modules/graphical.nix
      ../../modules/touchpad.nix
      ./users/souxd.nix
    ];
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

  # Enforce fstab options
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/swap".options = [ "noatime" ];
  };

  # swapDevices = [ { device = "/swap/swapfile"; } ];
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };

  networking.hostName = "damnix";
  time.timeZone = "Brazil/East";

  system.stateVersion = "22.05";

}
