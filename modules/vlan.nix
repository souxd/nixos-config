{ config, pkgs, ... }:

{
  services.zerotierone.enable = true;
  
  networking.firewall = {
    allowedTCPPortRanges = [
      # KDE Connect
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      # KDE Connect
      { from = 1714; to = 1764; }
    ]; 
  };

}
