{ config, pkgs, ... }:
{
  home.sessionVariables = { XKB_DEFAULT_OPTIONS = "ctrl:swapcaps"; };

  imports = [
    ../configuration.nix
    ./shell.nix
    ./programs.nix
    ./services.nix
    ./desktop/sway.nix
    ./emacs/custom.nix
    # noticeable lag on damnix
    # ./desktop/hyprland.nix
  ] ++
  (map (p: ../modules + p) [
    /nix-direnv.nix
    /media/mpd.nix
    /office/libreoffice.nix
    /office/zathura.nix
  ]);

  programs.home-manager.enable = true;

  home.sessionPath = [
    "\${HOME}/.npm-global"
  ];
}
