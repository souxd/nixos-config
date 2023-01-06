{ config, pkgs, ... }:
let
  plugin-pkg = pkgs.obs-studio-plugins;
in
{
  programs.obs-studio = {
    enable = true;
    plugins = with plugin-pkg; [
      wlrobs /* for wlroots */
    ];
  };
}
