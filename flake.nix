{
  description = "souxd's NixOS & Home Manager configurations";

  outputs = inputs:
    let system = "x86_64-linux"; in
    {
      nixosConfigurations = (
        import ./outputs/nixos-conf.nix {
          inherit inputs system;
        }
      );

      homeConfigurations = (
        import ./outputs/home-conf.nix {
          inherit inputs system;
        }
      );
    };

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    stablepkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nurpkgs.url = "github:nix-community/NUR";

    nix-alien.url = "github:thiagokokada/nix-alien";

    home-manager = {
      # master branch for newest modules
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    nix-gaming.url = "github:fufexan/nix-gaming";
  };
}
