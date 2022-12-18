# needed for (graphical) desktop usage
{ config, pkgs, ... }:

{
  security.polkit.enable = true; # needed if using WMs through home-manager
  security.pam.services.swaylock = { }; # fix swaylock not accepting user password

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = [ pkgs.vaapiIntel ]; # enable vaapi decoding
  };

  sound.enable = false; # pipewire misbehaves with this option set
  hardware.pulseaudio.enable = false; # unset since using pipewire

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  programs.xwayland.enable = true;

  programs.dconf.enable = true; # gtk theming needs this to work well

  services.flatpak.enable = true;

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
