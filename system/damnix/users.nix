{
  imports =
    (map (p: ../users + p) [
      /souxd/user.nix
    ]);
}
