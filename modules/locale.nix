{ config, pkgs, ... }:

{
  i18n.defaultLocale = "C.UTF-8";
  i18n.extraLocaleSettings = { LC_ALL = "pt_BR.UTF-8"; }; 
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };
#   i18n.inputMethod = {
#     enabled = "ibus";
#     ibus.engines = with pkgs.ibus-engines; [ mozc typing-booster m17n uniemoji ];
#   };

}
