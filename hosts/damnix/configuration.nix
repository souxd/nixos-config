# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/flake.nix
      ../../modules/cachix.nix
      ../../modules/emacs/emacs-overlay.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = { enable = true;
  version = 2;
  device = "/dev/sda";
  };

  # Encorce fstab options
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/swap".options = [ "noatime" ];
  };

  # Swap
  swapDevices = [ { device = "/swap/swapfile"; } ];

  networking.hostName = "damnix"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Brazil/East";

  # Select internationalisation properties.
  i18n.defaultLocale = "C.UTF-8";
  i18n.extraLocaleSettings = { LC_ALL = "pt_BR.UTF-8"; }; 
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };
   i18n.inputMethod = {
     enabled = "ibus";
     ibus.engines = with pkgs.ibus-engines; [ mozc typing-booster m17n uniemoji ];
     };

  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = { enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };
  programs.xwayland.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Configure keymap in X11
  services.xserver.layout = "br";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # opengl
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # Enable OpenTabletDriver
  hardware.opentabletdriver.daemon.enable = true;
  hardware.opentabletdriver.enable = true;

  # Enable sound.
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.souxd = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gnomeExtensions.gsconnect
  ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "22.05"; # Did you read the comment?

}
