{ config, ... }:

{
  imports = [
    ./shell.nix
    ./programs.nix
    ./services.nix
    ../../modules/sway.nix
    ../../modules/nix-direnv.nix
    ../../modules/emacs/doom-emacs.nix
    ../../modules/firefox.nix
    ../../modules/discord.nix
    ../../modules/gaming.nix
  ];

  programs.home-manager.enable = true;
}
