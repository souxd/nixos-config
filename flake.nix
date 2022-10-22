{
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    doom-emacs.url = "github:doomemacs/doomemacs/3853dff5e11655e858d0bfae64b70cb12ef685ac";
    doom-emacs.flake = false;
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs/";
    nix-doom-emacs.inputs.doom-emacs.follows = "doom-emacs";

  };  

  outputs = { nixpkgs, nixpkgs-stable, home-manager, nix-doom-emacs, ... }: let
  pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
  pkgs-stable = import nixpkgs-stable { system = "x86_64-linux"; config.allowUnfree = true; };
  in {

    nixosConfigurations = {
      damnix = nixpkgs-stable.lib.nixosSystem {
	system = "x86_64-linux";
        modules = 
	[ ./hosts/damnix/configuration.nix ];
      };
    };  

    homeConfigurations = {
    # nix build .#homeConfigurations.<user>.activationPackage
      souxd = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        stateVersion = "22.05";
        system = "x86_64-linux";
	username = "souxd";
	homeDirectory = "/home/souxd";
	configuration = {
          imports = [ ./users/souxd/home.nix nix-doom-emacs.hmModule ];
	};  
        extraSpecialArgs = { inherit pkgs-stable; };
      };
    };
  };
}
