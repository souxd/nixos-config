### qBittorrent-nox
# Bittorrent client, web UI exposed via :8080
# docs: https://github.com/qbittorrent/qBittorrent/wiki
# Note: you will need to set the user up manually
# (default credentials: `admin`, `adminadmin`)
{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.qbittorrent-nox ];
  networking.firewall.allowedTCPPorts = [ 8080 ];
}
