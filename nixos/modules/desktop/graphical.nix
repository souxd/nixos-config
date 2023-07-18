# needed for (graphical) desktop usage
{ config, pkgs, ... }:

{
  security.polkit.enable = true; # needed if using WMs through home-manager
  security.pam.services.swaylock = { }; # fix swaylock not accepting user password

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  programs.xwayland.enable = true;

  programs.dconf.enable = true; # gtk theming needs this to work well

  services.flatpak.enable = true;
  fonts.fontDir.enable = true; # fix flatpak fonts

  services.dbus = {
    enable = true;
    # TODO see the equivalent of dbus-update-activation-environment later
    #implementation = "broker";
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  security.rtkit.enable = true; # optional, but recommended

  ## audio settings
  sound.enable = false; # pipewire misbehaves with this option set
  hardware.pulseaudio.enable = false; # unset, using pipewire
  # pipewire
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # for old games
    pulse.enable = true;
    jack.enable = true; # for apps that requires jack
    wireplumber.enable = true;
  };
}
