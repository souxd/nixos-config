{ pkgs, specialArgs, ... }:

let
  inherit (specialArgs) gaming;
in
{
  home.packages = with pkgs; with gaming.packages.${pkgs.system}; [
    steam
    grapejuice
    retroarchFull
    gzdoom
    runelite
    #nix-gaming pkgs
    osu-lazer-bin
  ];
}
