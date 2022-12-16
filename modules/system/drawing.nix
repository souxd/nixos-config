# enable OTD driver for my wacom drawing table
{ config, ... }:

{
  services.xserver.libinput.enable = true;
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
}
