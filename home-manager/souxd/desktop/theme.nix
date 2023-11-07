# my preferred gtk and pointer themes
{ config, pkgs, ... }:

{
  # enable custom fonts
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; }) # term and glyphs
    font-awesome_4 # more glyphs, v5 doesnt work well with waybar and v6 messes my other fonts
    font-awesome_5 # need this for some extra glyphs
    powerline-fonts # unicode characters and glyphs
    noto-fonts-emoji # google emojis
    noto-fonts-cjk-sans # asian characters
    noto-fonts-cjk-serif # asian characters
  ];

  home.pointerCursor = {
    x11.enable = true;
    package = "${../../../assets/cursors/buufAnimated24}";
    name = "cursor-theme";
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
      package = "${../../../assets/cursors/buufAnimated24}";
      name = "cursor-theme";
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
