# settings i consider important for any hosts
{ config, pkgs, inputs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    /*
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 32d";
    };
    */
  };

  # channels and registry on flakes
  environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  nix.nixPath = [ "nixpkgs=/etc/nix/inputs/nixpkgs" ];
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; with inputs.nix-alien.packages.${system}; [
    nixFlakes
    age
    man-db
    neovim
    htop
    wget
    ripgrep
    fd
    # makes non-nix bins easier to use
    nix-alien
    nix-index
    nix-index-update
  ];

  # list packages installed on host
  environment.shellAliases = { nix-query = "nix-store -q --references /run/current-system/sw | rg -v man | sed 's/^[^-]*-//g' | sed 's/-[0-9].*//g' | rg -v '^nix' | sort -u"; };
}
