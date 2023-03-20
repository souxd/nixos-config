# i2pd config (lighter)
{ config, ... }:

{
  services.i2pd = {
    enable = true;
    port = 10123;
  };
}
