{
  description = "Henrik's Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
	nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    home-manager = {
        url = "github:nix-community/home-manager/release-25.05";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    bzmenu.url = "github:e-tho/bzmenu";
  };

  outputs =
    { nixpkgs, nix-flatpak, home-manager, ... }@inputs:

    {
      nixosConfigurations = {
        workpc = nixpkgs.lib.nixosSystem {          
          modules = [
            ./configuration.nix
            ./modules/apps.nix
            ./modules/services.nix
            ./modules/filesystem.nix
	    ./modules/misc.nix
	    nix-flatpak.nixosModules.nix-flatpak
	    home-manager.nixosModules.home-manager
          ];
          specialArgs = { inherit inputs; };
        };
        #vulcan = nixpkgs.lib.nixosSystem {
          #modules = [
            #./vulcan/configuration.nix
            #./vulcan/modules/apps.nix
            #./vulcan/modules/services.nix
            #./vulcan/modules/filesystem.nix
	    #nix-flatpak.nixosModules.nix-flatpak
          #];
          #specialArgs = { inherit inputs; };
        #};
      };
    };
}
