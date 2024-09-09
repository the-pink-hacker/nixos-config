{
    description = "A simple NixOS flake.";

    inputs = {
    	nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
	home-manager = {
	    url = "github:nix-community/home-manager";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
        firefox-addons = {
            url = "gitlab:rycee/nur-expressions/?dir=pkgs/firefox-addons";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    
    outputs = inputs@{  self, nixpkgs, home-manager, ... }:
    let
        system = "x86_64-linux";
        firefox-addons = inputs.firefox-addons.packages.${system};
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
	    modules = [
	    	./user/pink/config.nix
		./hardware/amd.nix
                ./hardware/bluetooth.nix
		./machine/pink-nixos-desktop/hardware-generated.nix
		./machine/pink-nixos-desktop/hardware.nix
		home-manager.nixosModules.home-manager
		{
		    home-manager = {
		        useGlobalPkgs = true;
			useUserPackages = true;
                        extraSpecialArgs = {
                            inherit firefox-addons;
                        };
			users.pink = import ./user/pink/home.nix;
		    };
		}
	    ];
	};

    	nixosConfigurations.pink-nixos-laptop = nixpkgs.lib.nixosSystem {
            inherit system;
	    modules = [
	    	./user/pink/config.nix
                ./hardware/fingerprint.nix
                ./hardware/bluetooth.nix
		./machine/pink-nixos-laptop/hardware-generated.nix
		./machine/pink-nixos-laptop/hardware.nix
		home-manager.nixosModules.home-manager
		{
		    home-manager = {
		        useGlobalPkgs = true;
			useUserPackages = true;
                        extraSpecialArgs = {
                            inherit firefox-addons;
                        };
			users.pink = import ./user/pink/home.nix;
		    };
		}
	    ];
	};
    };
}
