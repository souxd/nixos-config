{
  description = "souxd's NixOS & Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    stablepkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    trunkpkgs.url = "github:nixos/nixpkgs";
    nurpkgs.url = "github:nix-community/NUR";

    sops-nix.url = "github:Mic92/sops-nix"; # just for testing

    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-ld.url = "github:Mic92/nix-ld/main";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay";
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

      homeConfigurations = (
        import ./outputs/home-conf.nix {
          inherit inputs system;
        }
      );
    };
}
