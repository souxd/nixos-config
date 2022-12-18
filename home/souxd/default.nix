{ config, ... }:

{
  imports = [
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
  ]);

  programs.home-manager.enable = true;
}
