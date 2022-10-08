{ config, lib, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes  
    '';  
    
    #registry.nixpkgs.flake = nixpkgs;
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 32d";
    };
  };  
 
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
  pkgs.nixFlakes
  pkgs.man-db
  pkgs.git
  pkgs.neovim
  pkgs.wget
  ];

  environment.shellAliases = { nix-query = "nix-store -q --references /run/current-system/sw | rg -v man | sed 's/^[^-]*-//g' | sed 's/-[0-9].*//g' | rg -v '^nix' | sort -u"; };

}
