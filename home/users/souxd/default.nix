{ config, ... }:

{
  imports = [
    ./shell.nix
    ./programs.nix
    ./services.nix
    ../../modules/nix-direnv.nix
    ../../modules/emacs/doom-emacs.nix
    ../../modules/firefox.nix
    ../../modules/discord.nix
  ];

  programs.home-manager.enable = true;
}
