{ config, ... }:

{
  services.mako = {
    enable = true;

    font = "FiraCode Nerd Font";
    defaultTimeout = 15000;
  };
}
