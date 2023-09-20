self: super:

{
  privoxy = super.nixosModules.privoxy.overrideAttrs (oldAttrs: {
    description = "fix privoxy to use only types.str and no types.string";
    # Add your custom module configuration here

  });
}
