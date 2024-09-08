{
    description = "A simple NixOS flake.";

    inputs = {
    	nixpkgs.url = "github:NixOs/nixpkgs/nixos-24.05";
    	nixpkgs-unstable.url = "github:NixOs/nixpkgs/nixos-unstable";
	home-manager = {
	    url = "github:nix-community/home-manager/release-24.05";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
        plasma-manager = {
            url = "github:nix-community/plasma-manager";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.home-manager.follows = "home-manager";
        };
    };
    
    outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, plasma-manager, ... }:
    let
        system = "x86_64-linux";
        unstable = import nixpkgs-unstable { inherit system; };
    in
    {
        devShells."${system}".rust-bevy = let
            pkgs = import nixpkgs {
                inherit system;
            };
        in pkgs.mkShell rec {
            nativeBuildInputs = with pkgs; [
                pkg-config
                mold
            ];
            buildInputs = with pkgs; [
                udev
                alsa-lib
                vulkan-loader
                xorg.libX11
                xorg.libXcursor
                xorg.libXi
                xorg.libXrandr
                libxkbcommon
                wayland
            ];
            shellHook = "exec zsh";
            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
        };

    	nixosConfigurations.pink-nixos-desktop = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit unstable; };
	    modules = [
	    	./user/pink/config.nix
		./hardware/amd.nix
		./machine/pink-nixos-desktop/hardware-generated.nix
		./machine/pink-nixos-desktop/hardware.nix
		home-manager.nixosModules.home-manager
		{
		    home-manager = {
		        useGlobalPkgs = true;
			useUserPackages = true;
                        sharedModules = [
                            plasma-manager.homeManagerModules.plasma-manager
                        ];
                        extraSpecialArgs = { inherit unstable; inherit plasma-manager; };
			users.pink = import ./user/pink/home.nix;
		    };
		}
	    ];
	};

    	nixosConfigurations.pink-nixos-laptop = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit unstable; };
	    modules = [
	    	./user/pink/config.nix
                ./hardware/fingerprint.nix
		./machine/pink-nixos-laptop/hardware-generated.nix
		./machine/pink-nixos-laptop/hardware.nix
		home-manager.nixosModules.home-manager
		{
		    home-manager = {
		        useGlobalPkgs = true;
			useUserPackages = true;
                        extraSpecialArgs = { inherit unstable; };
			users.pink = import ./user/pink/home.nix;
		    };
		}
	    ];
	};
    };
}
