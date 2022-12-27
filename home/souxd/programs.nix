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
      ## Media
      hydrus
      # Audio
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

      ## Utils
      # nix
      steam-run
      appimage-run
      # passwords
      keepassxc
      # clock
      gnome.gnome-clocks
      # git, remove, ssh
      gh
      mosh
      rtsp-simple-server
      wolfssl
      # compatibility
      wineWowPackages.waylandFull
      winetricks
    ];
}
