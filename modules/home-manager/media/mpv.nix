{ config, ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      hwdec = "auto-safe";
      ao = "pipewire";
      vo = "gpu";
      gpu-context = "wayland";
    };
  };
}
