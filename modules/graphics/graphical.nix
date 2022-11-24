{ config, pkgs, ... }:

{
  imports = [ ../audio.nix ];

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
}
