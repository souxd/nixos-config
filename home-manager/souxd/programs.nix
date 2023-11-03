{ config, pkgs, lib, specialArgs, ... }:

let
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
    ## Media ##
    hydrus
    flashplayer-standalone
    yt-dlp # extract videos
    ytfzf
    streamlink # extract streams
    nicotine-plus # download music
    stremio # watch movies and series
    calibre # read e-books
    ## Games ##
    minetest
    prismlauncher
    x11Doomseeker
    zandronum-dev-bin
    gzdoom
    melonDS
    duckstation
    ppsspp-sdl-wayland
    snes9x-gtk
    # sm64ex-coop
    ## Web-browsers ##
    lynx
    avx-palemoon-bin
    flashplayer
    pipelight
    djview
    # Audio
    mpc-cli
    ymuse
    musescore
    reaper
    helm # synth vst
    yabridge
    yabridgectl

    ## Graphic ##
    imagemagick
    gimp
    inkscape
    xournalpp
    krita
    libresprite

    ## Video ##
    (vapoursynth.withPlugins [ffms])
    vapoursynth-editor
    ffmpeg_6-full
    olive-editor

    ## Social ##
    gajim # XMPP, GUI
    poezio # XMPP, CLI
    nheko # Matrix, GUI
    # gomuks # Matrix, CLI
    weechat # IRC, CLI
    mumble # VoIP, GUI
    ripcord-patched # discord, GUI

    ## Network ##
    wireshark

    ## Editors ##
    x11Slade # doom editor

    ## Utils ##
    xterm
    gnome.gnome-clocks
    calcurse
    # extractors
    unrar
    p7zip
    zip
    unzip
    # Git, remove, ssh
    gh
    mediamtx
    wolfssl


    ## Nix ##
    steam-run
    appimage-run

    ## Passwords ##
    libsecret
    keepassxc
    pinentry-curses

    ## Compatibility ##
    wineWowPackages.stagingFull
    mesa-demos
    adoptopenjdk-hotspot-bin-8 # JVM for old games
  ];

  xdg.mimeApps = let
    browser = [ "avx-palemoon-bin.desktop" ];
    archive = [ "file-roller.desktop" ];

    associations = {
      "inode/directory" = [ "pcmanfm.desktop" ];
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "application/vnd.adobe.flash.movie" = [ "flashplayer-standalone.desktop" ];
      "application/vnd.microsoft.portable-executable" = [ "wine.desktop" ];
      "application/x-ms-dos-executable" = [ "wine.desktop" ];
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
      "application/zip" = archive;
    };
  in {
    enable = true;
    associations.added = associations;
    defaultApplications = associations;
  };
  xdg.mime.enable = true;
}
