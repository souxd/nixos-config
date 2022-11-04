{
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs/";
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, nix-doom-emacs, ... }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      pkgs-stable = import nixpkgs-stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {

      nixosConfigurations = {
        damnix = nixpkgs-stable.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
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
          extraSpecialArgs = { inherit pkgs-stable; };
        };
      };
    };
}
