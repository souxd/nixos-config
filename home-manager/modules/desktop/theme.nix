# my preferred gtk and pointer themes
{ config, pkgs, ... }:

{
  # enable custom fonts
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; }) # term and glyphs
    font-awesome_4 # more glyphs, v6 messes my other fonts
    powerline-fonts # unicode characters and glyphs
    noto-fonts-emoji # google emojis
    noto-fonts-cjk-sans # asian characters
  ];

  home.pointerCursor = {
    x11.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    cursorTheme = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 16;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };
}
