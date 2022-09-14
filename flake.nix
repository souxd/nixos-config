{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.05";
    unstable.url = "github:nixOS/nixpkgs/nixos-unstable";  

    home-manager = {
      url = github:nix-community/home-manager/release-22.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        damnix = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./hosts/damnix/configuration.nix
	    {
	    nixpkgs.config.allowUnfree = true;
            environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
            nix.nixPath = [ "nixpkgs=/etc/nix/inputs/nixpkgs" ];
	    nix.registry.nixpkgs.flake = nixpkgs;
	    }
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.souxd = {
                imports = [ ./hosts/damnix/home.nix ];
	        xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
	    	nix.registry.nixpkgs.flake = nixpkgs;
              };
            }
          ];
	};
      };
    };
}
