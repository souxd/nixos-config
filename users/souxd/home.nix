{ config, lib, ... }:

{
  imports = [
    ./shell.nix
    ./programs.nix
    ./services.nix
    ../../home-modules/nix-direnv.nix
    ../../home-modules/emacs/doom-emacs.nix
    ../../home-modules/discord.nix
  ];

  programs.home-manager.enable = true;

}
