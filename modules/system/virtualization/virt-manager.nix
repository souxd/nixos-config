# enable virt-manager. Don't forget to add
# your user to libvirtd
{ config, pkgs, ... }:

{

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = [ pkgs.virt-manager ];
}
