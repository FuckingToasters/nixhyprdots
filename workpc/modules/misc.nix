{ config, pkgs, inputs, ... }:

{
  inputs.bzmenu.url = "github:e-tho/bzmenu";
  environment.systemPackages = [ inputs.bzmenu.packages.${pkgs.system}.default ];
}
