{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnumake
    git
    which
    coreutils
    findutils
    ncurses
    curl
    gawk
    stow
    fuse
    patchelf
  ];
}
