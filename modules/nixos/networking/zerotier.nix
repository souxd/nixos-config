# VLAN i use for convenience
{ config, stable, ... }:

{
  services.zerotierone = {
    enable = true;
    package = stable.zerotierone;
  };
}
