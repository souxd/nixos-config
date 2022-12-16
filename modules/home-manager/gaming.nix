{ pkgs, specialArgs, ... }:

let
  inherit (specialArgs) gaming;
in
{
  home.packages = with pkgs; with gaming.packages.${pkgs.system}; [
    # launchers
    steam
    runelite
    grapejuice
    retroarchFull
    # source ports
    gzdoom
    lzwolf
    iortcw_sp
    #nix-gaming pkgs
    osu-lazer-bin
  ];
}
