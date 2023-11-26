{ config, pkgs, ... }:

{
  nix.settings.max-jobs = 2;
  nix.settings.cores = 2;

  hardware.opengl = {
    driSupport32Bit = true; # for old games
    extraPackages = [ pkgs.vaapiIntel ]; # enable vaapi decoding
    extraPackages32 = [ pkgs.vaapiIntel ]; # enable vaapi decoding
  };

  musnix.enable = true;

  imports = [
    ../configuration.nix
    ./hardware-configuration.nix
    ./kernel
    ./network.nix
    ./programs.nix
    ./users.nix
    ./services.nix
  ] ++ (map (p: ../modules + p) [
    /printing.nix
    /locale
    /desktop/graphical.nix
    /desktop/drawing.nix
  ]);

  time.timeZone = "Brazil/East";
  environment.sessionVariables = { TZ = "Brazil/East"; };
  networking.hostName = "damnix";

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      extraConfig = ''
        nowatchdog
        nmi_watchdog=0
      '';
    };
  };

  swapDevices = [{ device = "/swap/swapfile"; }];

  # Enforce fstab options
  fileSystems = {
    "/".options = [ "compress=zstd:2" ];
    "/home".options = [ "compress=zstd:2" ];
    "/nix".options = [ "compress=zstd:2" "noatime" ];
    "/swap".options = [ "noatime" ];
  };
}
