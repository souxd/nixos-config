{ config, lib, pkgs, pkgs-stable, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "souxd";
  home.homeDirectory = "/home/souxd";
  
  services.easyeffects.enable = true;
  services.syncthing.enable = true;

  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      forceWayland = true;
      extraPolicies = {
        ExtensionSettings = {};
      };
    };
  };
  
  home.packages = [
    pkgs.reaper
    pkgs.inkscape
    pkgs.ffmpeg
    pkgs.grapejuice
    pkgs.deadbeef
    pkgs.dillo
    pkgs.calibre
    #pkgs.ripcord
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
    #pkgs.steam-run
    pkgs.appimage-run
    pkgs.kdenlive
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


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
