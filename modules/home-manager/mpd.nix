{ config, pkgs, ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "~/Música";
    extraConfig = ''
      audio_output {
            type    "pipewire"
            name    "MPD Pipewire Output"
      }
    '';
  };

  home.packages = [ pkgs.ymuse ];
}
