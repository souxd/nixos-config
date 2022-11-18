{
  description = "souxd's NixOS & Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    stablepkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    trunkpkgs.url = "github:nixos/nixpkgs";
    nurpkgs.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "stablepkgs";
    };

    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-ld.url = "github:Mic92/nix-ld/main";

    hyprland.url = "github:hyprwm/Hyprland";

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs/";
  };

  outputs = inputs:
    let system = "x86_64-linux"; in
    {
      nixosConfigurations = (
        import ./outputs/nixos-conf.nix {
          inherit inputs system;
        }
      );

      # nix build .#homeConfigurations.<user>.activationPackage
      homeConfigurations = (
        import ./outputs/home-conf.nix {
          inherit inputs system;
        }
      );
    };
}
