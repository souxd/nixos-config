{ config, pkgs, ... }:

{
  imports = [ ./audio.nix ./gnome.nix ];

  hardware.opengl = {
  enable = true;
  driSupport = true;
  driSupport32Bit = true;
  };

  services.xserver = { 
    enable = true;
    layout = "br"; # Configure keymap in X11
  };

  services.flatpak.enable = true;

  programs.xwayland.enable = true;
  environment.systemPackages = [
    pkgs.gnomeExtensions.gsconnect
    pkgs.gnomeExtensions.tiling-assistant
    pkgs.gnomeExtensions.vitals
    pkgs.gnomeExtensions.openweather
  ];

}
