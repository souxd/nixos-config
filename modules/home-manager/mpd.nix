{ config, pkgs, ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "~/Música";
  };

  home.packages = [ pkgs.ymuse ];
}
