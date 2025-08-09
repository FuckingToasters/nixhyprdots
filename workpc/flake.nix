{
  description = "Henrik's Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
	nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
        fingerprint-flake.url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
    home-manager = {
        url = "github:nix-community/home-manager/release-25.05";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    bzmenu.url = "github:e-tho/bzmenu";
    iwmenu.url = "github:e-tho/iwmenu";
    pwmenu.url = "github:e-tho/pwmenu";
  };

  outputs =
    { nixpkgs, nix-flatpak, home-manager, fingerprint-flake, ... }@inputs:

    {
      nixosConfigurations = {
        workpc = nixpkgs.lib.nixosSystem {          
          modules = [
            ./configuration.nix
            ./modules/apps.nix
            ./modules/services.nix
            ./modules/filesystem.nix
            ./modules/firewall.nix
	    ./modules/misc.nix
	    nix-flatpak.nixosModules.nix-flatpak
	    home-manager.nixosModules.home-manager
            fingerprint-flake.nixosModules.default
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
