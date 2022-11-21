{ config, lib, ... }:

{
  imports = [
    ./shell.nix
    ./programs.nix
    ./services.nix
    ../../modules/emacs/doom-emacs.nix
    ../../modules/discord.nix
  ];

  programs.home-manager.enable = true;

}
