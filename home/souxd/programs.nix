{ config, pkgs, stable, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "souxd";
      userEmail = "souxd@proton.me";
    };
  };

  home.packages = with pkgs;
    [
      deadbeef
      audacity
      musescore
      helm
      helvum
      reaper
      yabridge
      yabridgectl
      # Graphic
      imagemagick
      gimp
      inkscape
      calibre
      xournalpp
      krita
      blender
      # Video
      ffmpeg
      kdenlive
      mediainfo # required by kdenlive
      # Social
      mumble
      # Utils
      steam-run
      appimage-run
      keepassxc
      mosh
      rtsp-simple-server
      wolfssl
      wineWowPackages.waylandFull
      winetricks
    ];
}
