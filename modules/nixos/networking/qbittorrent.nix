### qBittorrent-nox
# Bittorrent client, web UI exposed via :8080
# docs: https://github.com/qbittorrent/qBittorrent/wiki
# Note: you will need to set the user up manually
# (default credentials: `admin`, `adminadmin`)
{ config, pkgs, ... }:

{

  environment.systemPackages = [ pkgs.qbittorrent-nox ];

  # add and enable systemd unit
  systemd = {
    packages = [ pkgs.qbittorrent-nox ];
    services."qbittorrent-nox@souxd" = {
      enable = true;
      serviceConfig = {
        Type = "simple";
        User = "souxd";
        ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];

}
