{ config, pkgs, specialArgs, stable, ... }:

let
  inherit (specialArgs) souxd;
in
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
      souxd.glaxnimate
      blender
      # Video
      ffmpeg
      libsForQt5.kdenlive
      mediainfo # required by kdenlive
      # Social
      mumble
      souxd.beebeep
      # Utils
      gh
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
