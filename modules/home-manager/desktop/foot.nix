# preferred wayland terminal
{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    # FIXME sends start requests too quick when restarting
    server.enable = false;
    settings = {
      main = {
        font = "FiraCode Nerd Font:size=11";
        dpi-aware = "yes";
      };

      mouse = { hide-when-typing = "yes"; };
      colors = {
        alpha = "0.8";
      };
    };
  };
}
