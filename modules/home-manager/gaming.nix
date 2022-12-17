# all the game packages i want
{ pkgs, specialArgs, ... }:

let
  inherit (specialArgs) gaming wolfenstein;
in

with pkgs;
with gaming.packages.${pkgs.system};
with wolfenstein;

{
  home.packages = [
    # launchers
    steam
    runelite
    grapejuice
    retroarchFull
    # doom
    gzdoom
    #nix-gaming pkgs
    osu-lazer-bin
    # wolfenstein
    lzwolf
    iortcw_sp
    enemyterritory
  ];
}
