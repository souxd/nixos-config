{ config, pkgs, ... }:

{
  services.xserver.libinput.enable = true;
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

}
