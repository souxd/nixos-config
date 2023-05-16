{ config, pkgs, ... }:

{
  home.packages = [ pkgs.xdg-utils pkgs.xdg-user-dirs ];
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  #Add support for ./local/bin
  home.sessionPath = [
    "\${HOME}/.local/bin"
  ];

  home.sessionVariables = {
    NIX_PATH =
      "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs\${NIX_PATH:+:$NIX_PATH}";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    XDG_STATE_HOME = "\${HOME}/.local/state";
  };
}
