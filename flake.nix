{
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-22.05";
    trunk.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "stable";
    };

    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-ld.url = "github:Mic92/nix-ld/main";

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs/";
  };

  outputs = { self, nixpkgs, stable, trunk, home-manager, nix-alien, nix-doom-emacs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-stable = import stable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-trunk = import trunk
        {
          inherit system;
          config.allowUnfree = true;
        };
    in
    {

      nixosConfigurations = {
        damnix = stable.lib.nixosSystem rec {
          inherit system;
          specialArgs = { inherit self system; };
          modules = [
            ({ self, system, ... }: {
              imports = [ self.inputs.nix-ld.nixosModules.nix-ld ];
              environment.systemPackages = with pkgs; with self.inputs.nix-alien.packages.${system}; [
                nix-alien
                nix-index # not necessary, but recommended
                nix-index-update
              ];
            })
            ./hosts/damnix/configuration.nix
            {
              environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
              nix.nixPath = [ "nixpkgs=/etc/nix/inputs/nixpkgs" ];
              nix.registry.nixpkgs.flake = nixpkgs;
            }
          ];
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
            xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
            nix.registry.nixpkgs.flake = nixpkgs;
          };
          extraSpecialArgs = { inherit pkgs-stable; inherit pkgs-trunk; };
        };
      };
    };
}
