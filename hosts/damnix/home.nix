{ config, pkgs, ... }:

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
  home.packages = with pkgs; [
    #xonotic
    grapejuice
    nheko
    amberol
    dillo
    calibre
    htop
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
    qt5.wrapQtAppsHook
    autoPatchelfHook
    steam-run
    appimage-run
    kdenlive
    fd
    gcc
    libgccjit
    ripgrep
    shellcheck
    git
    nodejs
    yarn
    rnnoise
    keepassxc
    wineWowPackages.staging
    qbittorrent-nox
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
    };
    sessionVariables = {
      EDITOR = "neovim";
      };
    initExtra = ''
    . "/etc/profiles/per-user/souxd/etc/profile.d/hm-session-vars.sh"
    '';
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
