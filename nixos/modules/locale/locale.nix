# mapkey and LANG settings
{ config, ... }:

{
  i18n.defaultLocale = "C.UTF-8"; # don't change this
  i18n.extraLocaleSettings = { LC_ALL = "en_US.UTF-8"; };
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  environment.sessionVariables = { XKB_DEFAULT_LAYOUT = "us"; }; # keymap wayland
  services.xserver.layout = "us"; #  keymap X11
  services.xserver.xkbOptions = "ctrl:swapcaps";
}
