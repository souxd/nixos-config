{ pkgs, config, ... }:

{
  imports = (map (p: ../modules + p) [
    /virtualization/virt-manager.nix
    /virtualization/podman.nix
  ]);

  programs.adb.enable = true;
  programs.wireshark.enable = true;
  programs.kdeconnect.enable = true;
}
