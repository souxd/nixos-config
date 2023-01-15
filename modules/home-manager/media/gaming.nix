# all the game packages i want
{ pkgs, specialArgs, ... }:

let
  inherit (specialArgs) gaming mlpnur;
in

with pkgs;
with gaming.packages.${pkgs.system};

{
  home.packages = [
    ## launchers
    runelite # runescape
    openmw # morrowind
    grapejuice # roblox
    retroarchFull # emulators
    prismlauncher # minecraft
    minetest
    steam
    # doom
    gzdoom
    # wolfenstein
    lzwolf
    iortcw_sp

    ## nix-gaming pkgs
    osu-lazer-bin
  ];
}
