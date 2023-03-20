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
      #souxd.flashplayer-standalone
      yt-dlp # extract videos
      streamlink # extract streams
      nicotine-plus
      # web-browser
      stable.palemoon
      (stable.qutebrowser.override { enableWideVine = true; })
      # Audio
      musescore
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
      stable.blender
      # Video
      vapoursynth
      vapoursynth-editor
      ffmpeg-full
      mkvtoolnix
      libsForQt5.kdenlive
      mediainfo # optional: kdenlive
      # Social
      mumble
      dino # xmpp
      ripcord
      souxd.beebeep

      ## Network
      wireshark

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
      wineWowPackages.stagingFull
      winetricks
      # JVM for old games
      adoptopenjdk-hotspot-bin-8
      # Create liveusb drives
      unetbootin
    ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "org.palemoon.palemoon.desktop";
      "x-scheme-handler/http" = "palemoon.desktop";
      "x-scheme-handler/https" = "palemoon.desktop";
      "x-scheme-handler/about" = "palemoon.desktop";
      "x-scheme-handler/unknown" = "palemoon.desktop";
    };
  };
}
