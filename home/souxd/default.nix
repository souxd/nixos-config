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
    /sway.nix
    /emacs/doom-emacs.nix
    /firefox.nix
    /gaming.nix
    /mpd.nix
    /libreoffice.nix
  ]);

  programs.home-manager.enable = true;
}
