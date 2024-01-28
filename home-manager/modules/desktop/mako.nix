# defaults for mako notification daemon
{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;

    font = "FiraCode Nerd Font";
    defaultTimeout = 15000;
    extraConfig = ''
      on-notify=exec ${pkgs.mpv}/bin/mpv --keep-open=no --volume=100 ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/message.oga
    '';
  };
}
