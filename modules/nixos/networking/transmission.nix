# lightweight torrent daemon
{ config, pkgs, ... }:

{
  services.transmission = {
    enable = true;
    settings = {
      peer-limit-global = 16;
      peer-limit-per-torrent = 2;
      speed-limit-down = 1500;
      speed-limit-down-enabled = true;
      speed-limit-up = 900;
      speed-limit-up-enabled = true;
    };
  };
}
