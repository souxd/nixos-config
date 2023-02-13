{ config, pkgs, ... }:

{
  import = [ ../../../modules/nixos/virtualization/qbittorrent.nix ];
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
}
