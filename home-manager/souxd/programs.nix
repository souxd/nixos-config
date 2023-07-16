{ config, pkgs, lib, specialArgs, ... }:

let inherit (specialArgs) souxd;
  x11Doomseeker = pkgs.writeShellScriptBin "doomseeker"
    ''
      #!/usr/bin/env sh
      env LC_ALL=C QT_QPA_PLATFORM=xcb ${pkgs.doomseeker}/bin/doomseeker
    '';

  x11Slade = pkgs.writeShellScriptBin "slade"
    ''
      #!/usr/bin/env sh
      env GDK_BACKEND=x11 ${pkgs.sladeUnstable}/bin/slade
    '';
in {
  programs = {
    git = {
      enable = true;
      delta.enable = true;
      extraConfig = {
        core.editor = "nvim";
      };
    };

    gpg.enable = true;

    neovim = {
      enable = true;
      extraConfig = ''
        set tabstop=2
        set shiftwidth=2
        set expandtab
        set smartindent
      '';
    };
  };

  home.packages = with pkgs; [
    ## Media
    # FIXME swftools buildphase is broken
    (hydrus.override { enableSwftools = false; })
    souxd.flashplayer-standalone
    yt-dlp # extract videos
    streamlink # extract streams
    nicotine-plus
    # games
    prismlauncher
    x11Doomseeker
    souxd.zandronum-dev
    melonDS
    duckstation
    snes9x-gtk
    # Web-browser
    lynx
    souxd.avx-palemoon-bin
    souxd.flashplayer
    tor-browser-bundle-bin
    # Audio
    mpc-cli
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
    (vapoursynth.withPlugins [ffms])
    vapoursynth-editor
    ffmpeg_6-full
    olive-editor
    # Social
    gajim # XMPP
    mirage-im # Matrix
    mumble # VoIP
    weechat # IRC
    souxd.ripcord-patched
    souxd.beebeep

    ## Network
    wireshark

    ## Editors
    x11Slade # doom editor

    ## Utils
    byobu
    xterm
    # Nix
    steam-run
    appimage-run
    # Passwords
    keepassxc
    pinentry-curses
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
    # extractors
    unrar
    p7zip
    unzip
  ];

  xdg.mimeApps = let
    browser = [ "avx-palemoon-bin.desktop" ];

    associations = {
      "inode/directory" = [ "pcmanfm.desktop" ];
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "application/vnd.microsoft.portable-executable" = [ "wine.desktop" ];
      "application/vnd.adobe.flash.movie" = [ "flashplayer-standalone.desktop" ];
      "text/plain" = [ "emacsclient.desktop" ];
      "video/mkv" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/chrome" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/xhtml+xml" = browser;
      "application/x-extension-xhtml" = browser;
      "application/x-extension-xht" = browser;
    };
  in {
    enable = true;
    associations.added = associations;
    defaultApplications = associations;
  };
  xdg.mime.enable = true;
}
