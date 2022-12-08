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
  };

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

  services.flatpak.enable = true;
  programs.xwayland.enable = true;

  environment.variables = { XDG_SESSION_TYPE = "wayland"; };
  environment.systemPackages = with pkgs; [ pavucontrol ];
}
