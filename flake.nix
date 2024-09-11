{
    description = "A simple NixOS flake.";

    inputs = {
    	nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
	home-manager = {
	    url = "github:nix-community/home-manager";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
        nur.url = "github:nix-community/nur";
    };
    
    outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
        system = "x86_64-linux";
        mksystem = import ./lib/mksystem.nix {
            inherit nixpkgs inputs;
        };
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

        nixosConfigurations = {
            pink-nixos-desktop = mksystem "pink-nixos-desktop" {
                user = "pink";
                system = "x86_64-linux";
                bluetooth = true;
                amdGraphics = true;
            };
            pink-nixos-laptop = mksystem "pink-nixos-laptop" {
                user = "pink";
                system = "x86_64-linux";
                bluetooth = true;
                battery = true;
                monitorBacklight = true;
                fingerprint = true;
            };
        };
    };
}
