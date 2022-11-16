{
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-22.05";
    trunk.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "stable";
    };

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs/";
  };

  outputs = { nixpkgs, stable, trunk, home-manager, nix-doom-emacs, ... }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      pkgs-stable = import stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      pkgs-trunk = import trunk
        {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
    in
    {

      nixosConfigurations = {
        damnix = stable.lib.nixosSystem {
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
          extraSpecialArgs = { inherit pkgs-stable; inherit pkgs-trunk; };
        };
      };
    };
}
