{ pkgs, config, ... }:

{
  imports = (map (p: ../modules + p) [
    /virtualization/virt-manager.nix
    /virtualization/podman.nix
  ]);

  programs.adb.enable = true;
  programs.wireshark.enable = true;
  programs.kdeconnect.enable = true;

  # zandronum ports
  networking.firewall.allowedTCPPortRanges = [{ from = 10666; to = 10670; }];
  networking.firewall.allowedUDPPortRanges = [{ from = 10666; to = 10670; }];
}
