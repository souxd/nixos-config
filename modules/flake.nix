{ pkgs, nixpkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes  
    '';  
    
    registry.nixpkgs.flake = nixpkgs;
  };
 
  environment.systemPackages = [ pkgs.nixFlakes ];
}
