{ config, lib, pkgs, stable, trunk, ... }:

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
      # Gnome Apps/Addons
      gnome.pomodoro
      drawing
      # Launchers & Games
      steam
      grapejuice
      retroarchFull
      gzdoom
      runelite
      # Audio & Music
      mumble
      deadbeef
      audacity
      musescore
      nodePackages.musescore-downloader
      helm
      helvum
      trunk.reaper
      trunk.yabridge
      trunk.yabridgectl
      # Graphic
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
      ripcord
      mumble
      hexchat
      # Utils
      hydrus
      keepassxc
      wireguard-tools
      wineWowPackages.waylandFull
      winetricks
      flatpak-builder
      steam-run
      appimage-run
      mosh
      # Libs & Runtimes
      tinycc
    ];
}
