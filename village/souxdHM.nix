{ config, lib, pkgs, pkgs-stable, ... }:

{
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
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
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
  home.packages = [
    pkgs.gnome.pomodoro
    pkgs.obsidian
    pkgs.bottles
    pkgs.melonDS
    pkgs.audacity
    pkgs.reaper
    pkgs.helm
    pkgs.inkscape
    pkgs.ffmpeg
    pkgs.grapejuice
    pkgs.deadbeef
    pkgs.dillo
    pkgs.calibre
    pkgs.ripcord
    #pkgs.heroic
    #pkgs.lutris
    #pkgs.hydrus
    #pkgs.xournalpp
    pkgs.tinycc
    pkgs.krita
    pkgs.blender
    pkgs.helvum
    pkgs.mumble
    pkgs.hexchat
    pkgs.wireguard-tools
    pkgs.mosh
    pkgs.nixfmt
    pkgs.shfmt
    pkgs.glslang
    pkgs.steam-run
    pkgs.steam
    pkgs.appimage-run
    pkgs.kdenlive
    pkgs.mediainfo
    pkgs.fd
    pkgs.gcc
    pkgs.libgccjit
    pkgs.ripgrep
    pkgs.shellcheck
    pkgs.nodejs
    pkgs.yarn
    pkgs.keepassxc
    pkgs.wineWowPackages.waylandFull
    pkgs.winetricks
    pkgs.qbittorrent-nox
    pkgs.gzdoom
    pkgs.gnumake
    pkgs.cmake
    pkgs.libtool
    pkgs.binutils 
    pkgs.glibc
    pkgs.lld
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
      EDITOR = "neovim";
      };
    };

  home.sessionVariables = rec {
    XDG_CACHE_HOME  	= "\${HOME}/.cache";
    XDG_CONFIG_HOME 	= "\${HOME}/.config";
    XDG_DATA_HOME   	= "\${HOME}/.local/share";
    EDITOR		= "emacsclient -t";
    VISUAL	        = "gnome-text-editor";
    MOZ_USE_XINPUT2	= "1";
    MOZ_ENABLE_WAYLAND	= "1";
    NIX_PATH 		= "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
  };

  home.stateVersion = "22.05";

    programs.home-manager.enable = true; # Let Home Manager install and manage itself.

}
