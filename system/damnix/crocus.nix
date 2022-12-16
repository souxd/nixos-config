# force crocus
{ config, ... }:

{
  environment.variables = { MESA_LOADER_DRIVER_OVERRIDE = "crocus"; };
}
