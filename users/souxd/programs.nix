{ config, lib, pkgs, ... }:

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
    # gnome apps/addons
    [
      gnome.pomodoro
      drawing
    ] ++
    # games
    [
      lutris
      steam
      grapejuice
      melonDS
      gzdoom
    ] ++
    # audio
    [
      deadbeef
      audacity
      reaper
      musescore
      nodePackages.musescore-downloader
      helm
      helvum
    ] ++
    # graphic
    [
      gimp
      inkscape
      calibre
      xournalpp
      krita
      blender
    ] ++
    # video
    [
      ffmpeg
      kdenlive
      mediainfo
    ] ++
    # social
    [
      ripcord
      mumble
      hexchat
    ] ++
    # utils
    [
      hydrus
      keepassxc
      wireguard-tools
      wineWowPackages.waylandFull
      winetricks
      flatpak-builder
      steam-run
      appimage-run
      mosh
    ] ++
    # libs & runtimes
    [
      tinycc
    ];

}
