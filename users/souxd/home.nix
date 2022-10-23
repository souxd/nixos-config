{ config, lib, pkgs, pkgs-stable, ... }:

{
  imports = [
    ../../modules/emacs/emacs-doom.nix
  ];

  home.username = "souxd";
  home.homeDirectory = "/home/souxd";
  
  services = {
    easyeffects.enable = true;
    syncthing.enable = true;
  };

  programs = {
    git = {
      userName = "souxd";
      userEmail = "souxd@proton.me";
    };
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        forceWayland = true;
        extraPolicies = {
          ExtensionSettings = {};
        };
      };
    };
  };

  home.packages = with pkgs; [
    tor-browser-bundle-bin
    gnome-feeds
    gnome.pomodoro
    dos2unix
    melonDS
    totem-pl-parser
    audacity
    reaper
    musescore
    nodePackages.musescore-downloader
    helm
    inkscape
    ffmpeg
    grapejuice
    deadbeef
    dillo
    calibre
    ripcord
    heroic
    lutris
    hydrus
    xournalpp
    tinycc
    krita
    blender
    helvum
    mumble
    hexchat
    wireguard-tools
    mosh
    nixfmt
    shfmt
    glslang
    steam-run
    steam
    appimage-run
    kdenlive
    mediainfo
    fd
    gcc
    libgccjit
    ripgrep
    shellcheck
    nodejs
    yarn
    keepassxc
    wineWowPackages.waylandFull
    winetricks
    gzdoom
    gnumake
    cmake
    libtool
    binutils 
    glibc
    lld
  ];

  programs.bash = { 
    enable = true;
    shellAliases = {
      ".." = "cd ..";
      "e" = "emacsclient -t";
      "nixupdate" = "sudo nixos-rebuild switch --flake .#damnix";
      "homeupdate" = "nix build .#homeConfigurations.souxd.activationPackage && result/activate";
    };
    sessionVariables = {
      EDITOR = "nvim";
      };
  };

  home.sessionVariables = rec {
    XDG_CACHE_HOME  	= "\${HOME}/.cache";
    XDG_CONFIG_HOME 	= "\${HOME}/.config";
    XDG_DATA_HOME   	= "\${HOME}/.local/share";
    EDITOR		= "nvim";
    VISUAL	        = "gnome-text-editor";
    MOZ_USE_XINPUT2	= "1";
    MOZ_ENABLE_WAYLAND	= "1";
    NIX_PATH 		= "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
  };

  home.stateVersion = "22.05";

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

}