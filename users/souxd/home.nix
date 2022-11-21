{ config, lib, ... }:

{
  imports = [
    ./shell.nix
    ./programs.nix
    ./services.nix
    ../../modules/emacs/doom-emacs.nix
    ../../modules/discord.nix
  ];

  home.username = "souxd";
  home.homeDirectory = "/home/souxd";
  home.stateVersion = "22.05";

  # workaround for https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = _: true;

  programs.home-manager.enable = true;

}
