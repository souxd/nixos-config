{ config, pkgs, ... }:

{
  nixpkgs.overlays =
    let
      DiscordOpenAsar = self: super: {
        discord = super.discord.override { withOpenASAR = true; };
      };
    in
    [ DiscordOpenAsar ];

  home.packages = with pkgs; [ discord ];
}
