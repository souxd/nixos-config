# WARN: this file will get overwritten by $ cachix use <name>
{ pkgs, lib, ... }:

{
  imports = [
    ./cachix/nix-community.nix
    ./cachix/hyprland.nix
  ];

  nix.settings.substituters = [ "https://cache.nixos.org/" ];

  environment.systemPackages = with pkgs; [ cachix ];
}
