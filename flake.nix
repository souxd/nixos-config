{
  description = "my system flake :)";

  inputs = {
    # Stable NixOS nixpkgs package set; pinned to 22.05
    nixpkgs.url = "github:Nixos/nixpkgs/22.05";
    # Unstable NixOS package set; Packages from the last succesful Hydra jobset
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Only pull from 'trunk' when channels are blocked by a Hydra jobset
    # failure or the 'unstable' channel has not otherwise updated recently
    trunk.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "/nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
      overlays = {
        # Inject 'unstable' and 'trunk' into the overridden package set, so that
	# the following overlays may access them (along with any system configs
	# that wish to do so)
	pkg-sets = (
	  final: prev: {
	    unstable = import inputs.unstable { system = final.system; };
	    trunk = import inputs.trunk { system = final.system; };
	  }
	);  
    };
      nixosConfigurations = {
        damnix = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = 
	    let
	      defaults = { pkgs, ... }: {
	        _module.args.unstable = import inputs.unstable { inherit (pkgs.stdenv.targetPlatform) system; };
	      };
	    in [ 
              ./hosts/damnix/configuration.nix
	      {
	      nixpkgs.config.allowUnfree = true;
              environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
              nix.nixPath = [ "nixpkgs=/etc/nix/inputs/nixpkgs" ];
	      nix.registry.nixpkgs.flake = inputs.nixpkgs;
	      }
	      defaults
              inputs.home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.souxd = {
                  imports = [ ./hosts/damnix/home.nix ];
	          _module.args.inputs = inputs;
	          xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
	    	  nix.registry.nixpkgs.flake = nixpkgs;
              };
	  }
          ];
	};
      };
  };
}
