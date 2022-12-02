{ config, pkgs, lib, ... }:

{
  imports = [ ./graphical.nix ];

  programs.hyprland.enable = true;
}
