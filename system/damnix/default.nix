{ config, pkgs, ... }:

{
  nix.settings.max-jobs = 2;
  nix.settings.cores = 2;

  services.xserver.videoDrivers = [
    "crocus"
    "i915"
    "modesetting"
    "fbdev"
  ];
  hardware.opengl = {
    driSupport32Bit = true; # for old games
    extraPackages = [ pkgs.vaapiIntel ]; # enable vaapi decoding
    extraPackages32 = [ pkgs.vaapiIntel ]; # enable vaapi decoding
  };

  imports = [
    ../configuration.nix
    ./hardware-configuration.nix
    ./mods.nix
    ./programs.nix
    ./users.nix
    ./services.nix
  ] ++ (map (p: ../../modules/nixos + p) [
    /printing.nix
    /locale/br-locale.nix
    /desktop/graphical.nix
    /desktop/drawing.nix
  ]);

  networking.hostName = "damnix";
  time.timeZone = "Brazil/East";
  environment.sessionVariables = { TZ = "Brazil/East"; };

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      extraConfig = ''
        nowatchdog
        nmi_watchdog=0
      '';
    };

    kernelPackages = pkgs.linuxPackages_xanmod_latest;
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
