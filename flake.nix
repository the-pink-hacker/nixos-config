{
    description = "A simple NixOS flake.";

    inputs = {
    	nixpkgs.url = "github:NixOs/nixpkgs/nixos-24.05";
	home-manager = {
	    url = "github:nix-community/home-manager/release-24.05";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
    };
    
    outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    	nixosConfigurations.pink-nixos-desktop = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
	    modules = [
	    	./configuration.nix
		./nvidia.nix
		./hardware-configuration.nix
		home-manager.nixosModules.home-manager
		{
		    home-manager = {
		        useGlobalPkgs = true;
			useUserPackages = true;
			users.pink = import ./home.nix;
		    };
		}
	    ];
	};
    };
}
