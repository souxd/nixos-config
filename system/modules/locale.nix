{ config, pkgs, ... }:

{
  i18n.defaultLocale = "C.UTF-8";
  i18n.extraLocaleSettings = { LC_ALL = "pt_BR.UTF-8"; };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };
}
