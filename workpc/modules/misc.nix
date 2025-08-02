{ inputs, ... }:
{
  environment.systemPackages = [ inputs.bzmenu.packages.${pkgs.system}.default ];
}
