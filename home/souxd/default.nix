{ config, ... }:

{
  imports = [
    ../configuration.nix
    ./shell.nix
    ./programs.nix
    ./services.nix
  ] ++
  (map (p: ../../modules/home-manager + p) [
    /nix-direnv.nix
    /desktop/sway.nix
    /emacs/doom-emacs.nix
    /media/gaming.nix
    /media/mpd.nix
    /media/obs.nix
    /office/libreoffice.nix
    /office/zathura.nix
  ]);

  programs.home-manager.enable = true;
}
