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
      palemoon
      # Audio
      musescore
      helvum
      reaper
      helm
      yabridge
      yabridgectl
      # Graphic
      imagemagick
      gimp
      inkscape
      calibre
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
      wineWowPackages.waylandFull
      winetricks
      # jvm
      graalvm17-ce
    ];
}
