# preferred wayland terminal
{ config, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "FiraCode Nerd Font:size=11";
        dpi-aware = "yes";
      };

      mouse = { hide-when-typing = "yes"; };
    };
  };
}
