{ config, pkgs, ... }:

{
  imports = [
    ../configuration.nix
    ./hardware-configuration.nix
    ./crocus.nix
    ./users.nix
  ] ++
  (map (p: ../../modules/nixos + p) [
    /printing.nix
    /locale/br-locale.nix
    /networking/qbittorrent.nix
    /networking/i2p.nix
    /networking/hamachi.nix
    /networking/zerotier.nix
    /networking/kdeconnect.nix
    /desktop/graphical.nix
    /desktop/drawing.nix
  ]);

  # disable if not needed
  networking.firewall.enable = true;

  networking.hostName = "damnix";
  time.timeZone = "Brazil/East";
  environment.sessionVariables = { TZ = "Brazil/East"; };

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.zpool=z3fold"
      "vm.swappiness=50"
      "vm.vfs_cache_pressure=150"
      /* params for zram
        "vm.vfs_cache_pressure=500"
        "vm.swappiness=100"
        "vm.dirty_background_ratio=1"
        "vm.dirty_ratio=50"
      */
    ];

    initrd.kernelModules = [ "zstd" "z3fold" ];
  };

  swapDevices = [{ device = "/swap/swapfile"; }];

  # Enforce fstab options
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/swap".options = [ "noatime" ];
  };

  /* use zswap, more ram to run apps
    zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    };
  */
}
