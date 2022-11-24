{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ starship exa atuin ];

  programs.bash = {
    enable = true;
    shellAliases = {
      "ls" = "exa";
      ".." = "cd ..";
      "sudo" = "sudo ";
      "e" = "emacsclient -t";
      "nixupdate" = "sudo nixos-rebuild switch --flake .#damnix";
      "homeupdate" =
        "nix build .#homeConfigurations.souxd.activationPackage && result/activate";
    };
    initExtra = ''
      export ATUIN_NOBIND="true"
      eval "$(starship init bash)"
      eval "$(atuin init bash)"
      bind -x '"\C-r": __atuin_history'
    '';
    sessionVariables = {
      EDITOR = "emacsclient -c";
    };
    bashrcExtra = ''
      nixify() {
        if [ ! -e ./.envrc ]; then
          echo "use nix" > .envrc
          direnv allow
        fi
        if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
          cat > default.nix <<'EOF'
      with import <nixpkgs> {};
      mkShell {
        nativeBuildInputs = [
          bashInteractive
        ];
      }
      EOF
          ${EDITOR:-vim} default.nix
        fi
      }
      flakify() {
        if [ ! -e flake.nix ]; then
          nix flake new -t github:nix-community/nix-direnv .
        elif [ ! -e .envrc ]; then
          echo "use flake" > .envrc
          direnv allow
        fi
        ${EDITOR:-vim} flake.nix
      }
    '';
  };

  home.sessionVariables = rec {
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    EDITOR = "emacsclient -c";
    VISUAL = "emacsclient -c";
    MOZ_USE_XINPUT2 = "1";
    MOZ_ENABLE_WAYLAND = "1";
    WINEDLLOVERRIDES = "winemenubuilder.exe=d";
    NIX_PATH =
      "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs\${NIX_PATH:+:$NIX_PATH}";
  };
}
