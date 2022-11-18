{ config, lib, pkgs, stable, trunk, nur, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "souxd";
      userEmail = "souxd@proton.me";
    };
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        forceWayland = true;
        extraPolicies = { ExtensionSettings = { }; };
      };
    };
  };

  manual.manpages.enable = false;
  home.packages = with pkgs;
    [
      # Gnome apps/addons
      gnome.pomodoro
      drawing
      # Games
      lutris
      steam
      grapejuice
      retroarchFull
      melonDS
      gzdoom
      # Audio
      deadbeef
      audacity
      musescore
      nodePackages.musescore-downloader
      helm
      helvum
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
      # Libs & runtimes
      tinycc
    ] ++
    [
      trunk.reaper
    ];

}
