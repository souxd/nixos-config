{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "souxd";
  home.homeDirectory = "/home/souxd";


  services.easyeffects.enable = true;
  services.emacs.enable = true;
  services.syncthing.enable = true;

  nixpkgs.config.allowUnfree = true;
  home.packages = [
    pkgs.heroic
    pkgs.steam
    pkgs.lutris
    pkgs.hydrus
    pkgs.xournalpp
    pkgs.tinycc
    pkgs.krita
    pkgs.dotnet-sdk
    pkgs.blender
    pkgs.helvum
    pkgs.mumble
    pkgs.hexchat
    pkgs.wireguard-tools
    pkgs.mosh
    pkgs.nixfmt
    pkgs.shfmt
    pkgs.glslang
    pkgs.appimage-run
    #pkgs.emacs28NativeComp
    pkgs.kdenlive
    pkgs.fd
    pkgs.gcc
    pkgs.libgccjit
    pkgs.ripgrep
    pkgs.shellcheck
    pkgs.git
    pkgs.nodejs
    pkgs.yarn
    pkgs.rnnoise
    pkgs.keepassxc
    pkgs.chromium
    pkgs.wineWowPackages.waylandFull
    pkgs.qbittorrent-nox
    pkgs.gzdoom
    pkgs.gnumake
    pkgs.cmake
    pkgs.libtool
    pkgs.binutils 
    pkgs.glibc
    pkgs.lld
  ];

  home.sessionVariables = rec {
    XDG_CACHE_HOME  	= "\${HOME}/.cache";
    XDG_CONFIG_HOME 	= "\${HOME}/.config";
    XDG_DATA_HOME   	= "\${HOME}/.local/share";
    VISUAL	        = "emacsclient -c";
    NIX_PATH 		= "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
  };

  programs.bash = { enable = true; };

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
