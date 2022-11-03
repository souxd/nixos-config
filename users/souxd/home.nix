{ config, lib, pkgs, pkgs-stable, ... }:

{
  imports = [
    ./shell.nix
    ./programs.nix
    ./services.nix
    ../../modules/emacs/emacs-doom.nix
    ../../modules/discord.nix
  ];

  home.username = "souxd";
  home.homeDirectory = "/home/souxd";

  home.stateVersion = "22.05";

  programs.home-manager.enable =
    true; # Let Home Manager install and manage itself.

}
