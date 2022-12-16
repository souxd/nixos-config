# podman wrapper
{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.distrobox ];
}
