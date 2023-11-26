{ config, pkgs, inputs, ... }:
let
  inherit inputs;

  nnnDesktopItem = pkgs.makeDesktopItem {
    name = "nnn";
    desktopName = "Fast ncurses file manager";
    exec = "footclient nnn";
    terminal = true;
  };
in
{
  home.packages = [ nnnDesktopItem ];

  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withNerdIcons = true; });
    extraPackages = with pkgs; [ bat exa fzf mediainfo ffmpegthumbnailer sxiv xdragon ];
    plugins = {
      src = "${inputs.nnn-plugins}/plugins";
      mappings = {
        c = "fzcd";
        f = "finder";
        o = "fzopen";
        p = "preview-tui";
        t = "nmount";
        v = "imgview";
        D = "dragdrop";
      };
    };
    bookmarks = {
      d = "~/Documents";
      D = "~/Downloads";
      p = "~/Pictures";
      v = "~/Videos";
      m = "/mnt";
      "/" = "/";
    };
  };
}
