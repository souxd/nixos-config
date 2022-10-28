{ pkgs, config, ... }:

{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    emacsPackage = pkgs.emacsNativeComp;
  };

  services.emacs = {
    enable = true;
    # package = doom-emacs; # Not needed if you're using the Home-Manager module instead
  };

  home.packages = [ pkgs.gdb pkgs.graphviz ];

}
