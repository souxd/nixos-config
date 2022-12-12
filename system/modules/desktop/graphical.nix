{ config, pkgs, ... }:

{
  security.polkit.enable = true; # needed if using WMs through home-manager

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ vaapiIntel ];
  };

  # configure keymap
  environment.sessionVariables = { XKB_DEFAULT_LAYOUT = "br"; };
  services.xserver.layout = "br"; # Configure keymap in X11

  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  programs.xwayland.enable = true;

  services.flatpak.enable = true;
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [ pulseaudio playerctl pavucontrol ];
}
