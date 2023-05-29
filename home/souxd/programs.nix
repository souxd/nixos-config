{ config, pkgs, specialArgs, ... }:

let inherit (specialArgs) souxd;
in {
  programs = {
    git = {
      enable = true;
      userName = "souxd";
      userEmail = "souxd@proton.me";
    };
  };

  home.packages = with pkgs; [
    ## Media
    hydrus
    souxd.flashplayer
    yt-dlp # extract videos
    streamlink # extract streams
    nicotine-plus
    # games
    godot_4
    retroarchFull
    prismlauncher
    doomseeker
    souxd.zandronum-dev
    quake3e
    dwarf-fortress-packages.dwarf-fortress-full
    # Web-browser
    souxd.avx-palemoon-bin
    souxd.flashplayer-standalone
    tor-browser-bundle-bin
    # Audio
    ymuse
    musescore
    reaper
    helm
    yabridge
    yabridgectl
    # E-books
    calibre
    # Graphic
    imagemagick
    gimp
    inkscape
    xournalpp
    krita
    libresprite
    # Video
    vapoursynth
    vapoursynth-editor
    ffmpeg_6-full
    olive-editor
    # Social
    mumble
    dino # xmpp
    souxd.ripcord-patched
    souxd.beebeep

    ## Network
    wireshark

    ## Editors
    sladeUnstable # doom editor
    # Lunarvim, unwrapped
    gcc
    gnumake
    pythonPackages.pip
    python
    nodejs
    cargo

    ## Utils
    xterm
    # Nix
    steam-run
    appimage-run
    # Passwords
    keepassxc
    # Clock & Calendar
    gnome.gnome-clocks
    calcurse
    # Git, remove, ssh
    gh
    zellij
    mediamtx
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
      "application/pdf" = "org.pwmt.zathura.desktop";
      "text/plain" = "lvim.desktop";
      "text/html" = "palemoon-bin.desktop";
      "video/mkv" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "x-scheme-handler/http" = "palemoon-bin.desktop";
      "x-scheme-handler/https" = "palemoon-bin.desktop";
      "x-scheme-handler/about" = "palemoon-bin.desktop";
      "x-scheme-handler/unknown" = "palemoon-bin.desktop";
    };
  };
}
