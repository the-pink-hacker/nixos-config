{
    description = "A simple NixOS flake.";

    inputs = {
    	nixpkgs.url = "github:NixOs/nixpkgs/nixos-24.05";
    	nixpkgs-unstable.url = "github:NixOs/nixpkgs/nixos-unstable";
	home-manager = {
	    url = "github:nix-community/home-manager/release-24.05";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
    };
    
    outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
        system = "x86_64-linux";
        unstable = import nixpkgs-unstable { inherit system; };
    in
    {
    	nixosConfigurations.pink-nixos-desktop = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit unstable; };
	    modules = [
	    	./configuration.nix
		./nvidia.nix
		./hardware-configuration.nix
		home-manager.nixosModules.home-manager
		{
		    home-manager = {
		        useGlobalPkgs = true;
			useUserPackages = true;
                        extraSpecialArgs = { inherit unstable; };
			users.pink = import ./home.nix;
		    };
		}
	    ];
	};
    };
}
