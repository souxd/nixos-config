# daemonless, rootless containers
{ config, pkgs, ... }:

{
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
    };
  };

  environment.systemPackages = [ pkgs.podman-compose pkgs.distrobox ];
}
