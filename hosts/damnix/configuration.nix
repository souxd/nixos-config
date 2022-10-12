{ config, pkgs, pkgs-stable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/default.nix
      ../../modules/cachix.nix
      ../../modules/locale.nix
      ../../modules/vlan.nix
      ../../modules/graphical.nix
      ../../modules/touchpad.nix
      ./users/souxd.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
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
  };

  networking.hostName = "damnix"; # Define your hostname.
  time.timeZone = "Brazil/East";
  
  system.stateVersion = "22.05";

}
