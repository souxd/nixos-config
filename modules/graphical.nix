{ config, pkgs, ... }:

{
  hardware.opengl = {
  enable = true;
  driSupport = true;
  driSupport32Bit = true;
  };

  services.xserver = { 
    enable = true;
    layout = "br"; # Configure keymap in X11
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true; # apparently this causes input delay on wayland :/
  };

  services = {
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
    flatpak.enable = true;
    gnome = {
      core-developer-tools.enable = true;
      tracker.enable = true;
      tracker-miners.enable = true;
    };
  };

  programs.xwayland.enable = true;
  environment.systemPackages = [
    pkgs.gnomeExtensions.gsconnect
  ];

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

}
