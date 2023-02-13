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
      ffmpeg
      libsForQt5.kdenlive
      mediainfo # optional: kdenlive
      # Social
      mumble
      dino # xmpp
      ripcord
      souxd.beebeep

      ## Utils
      # nix
      steam-run
      appimage-run
      # network
      wireshark
      # doom editor
      sladeUnstable
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
      bottles
      wineWowPackages.stagingFull
      winetricks
      # jvm for old games
      adoptopenjdk-hotspot-bin-8
      # create liveusb drives
      unetbootin
    ];
}
