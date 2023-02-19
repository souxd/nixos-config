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
      yt-dlp # extract videos
      streamlink # extract streams
      # web-browser
      stable.palemoon
      qutebrowser
      # Audio
      musescore
      stable.helvum
      reaper
      helm
      yabridge
      yabridgectl
      # Graphic
      imagemagick
      gimp
      inkscape
      xournalpp
      krita
      libresprite
      souxd.glaxnimate
      blender
      # Video
      ffmpeg-full
      libsForQt5.kdenlive
      mediainfo # optional: kdenlive
      # Social
      mumble
      dino # xmpp
      ripcord
      souxd.beebeep

      ## Network
      wireshark
      transgui

      ## Editors
      sladeUnstable

      ## Utils
      # Nix
      steam-run
      appimage-run
      # Passwords
      keepassxc
      # Clock
      gnome.gnome-clocks
      # Git, remove, ssh
      gh
      mosh
      rtsp-simple-server
      wolfssl
      # Compatibility
      bottles
      wineWowPackages.stagingFull
      winetricks
      # JVM for old games
      adoptopenjdk-hotspot-bin-8
      # Create liveusb drives
      unetbootin
    ];
}
