{ config, pkgs, stable, ... }:

{
  home.packages = with pkgs; [
    stable.libreoffice
    hunspell
    hunspellDicts.en_US
    hunspellDicts.pt_BR
  ];
}
