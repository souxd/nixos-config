{ pkgs, config, ... }:

{
  imports = (map (p: ../modules + p) [
    /virtualization/virt-manager.nix
    /virtualization/podman.nix
  ]);

  virtualisation.waydroid.enable = true;
  programs.adb.enable = true;
  programs.wireshark.enable = true;
  programs.kdeconnect.enable = true;
}
