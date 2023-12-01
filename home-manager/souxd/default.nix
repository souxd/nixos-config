{ config, pkgs, ... }:
{
  home.sessionVariables = {
    XKB_DEFAULT_OPTIONS = "ctrl:swapcaps";
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  };

  imports = [
    ../configuration.nix
    ./shell.nix
    ./programs.nix
    ./services.nix
    ./desktop/sway.nix
    ./media/mpv.nix
    ./emacs/custom.nix
  ] ++
  (map (p: ../modules + p) [
    /nix-direnv.nix
    /media/mpd.nix
    /office/libreoffice.nix
    /office/zathura.nix
    /web-browsers/firefox.nix
  ]);

  programs.home-manager.enable = true;

  home.sessionPath = [
    "\${HOME}/.npm-global"
  ];
}
