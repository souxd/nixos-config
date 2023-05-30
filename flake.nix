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
        import ./outputs/hm-conf.nix {
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

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    sops-nix.url = "github:Mic92/sops-nix";

    /* not in use

    not in use
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    prjc-patches = {
      url = "gitlab:alfredchen/projectc";
      flake = false;
    };

    nnn-plugins = {
      url = "github:jarun/nnn";
      flake = false;
    };
  */
  };
}
