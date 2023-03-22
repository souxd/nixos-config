{ config, pkgs, ... }:

{
  nix.settings.max-jobs = 2;

  imports = [
    ../configuration.nix
    ./hardware-configuration.nix
    ./mods.nix
    ./users.nix
  ] ++
  (map (p: ../../modules/nixos + p) [
    /printing.nix
    /locale/br-locale.nix
    /virtualization/virt-manager.nix
    /virtualization/podman.nix
    /networking/transmission.nix
    /networking/i2pd.nix
    /networking/hamachi.nix
    /networking/zerotier.nix
    /networking/kdeconnect.nix
    /desktop/graphical.nix
    /desktop/drawing.nix
  ]);

  programs.wireshark.enable = true;
  # disable if not needed
  networking.firewall.enable = true;
  # zandronum
  networking.firewall.allowedTCPPortRanges = [{ from = 10666; to = 10670; }];
  networking.firewall.allowedUDPPortRanges = [{ from = 10666; to = 10670; }];

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
      # zram
      /*"zswap.enabled=0"
        "vm.vfs_cache_pressure=500"
        "vm.swappiness=100"
        "vm.dirty_background_ratio=1"
        "vm.dirty_ratio=50"
      */
    ];
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
