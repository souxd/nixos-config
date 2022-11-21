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
        extraPolicies = { ExtensionSettings = { }; };
      };
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
      # Audio & Music
      deadbeef
      audacity
      musescore
      nodePackages.musescore-downloader
      helm
      helvum
      trunk.reaper
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
