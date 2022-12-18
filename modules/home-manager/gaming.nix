# all the game packages i want
{ pkgs, specialArgs, ... }:

let
  inherit (specialArgs) gaming mlpnur;
in

with pkgs;
with gaming.packages.${pkgs.system};

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
  ];
}
