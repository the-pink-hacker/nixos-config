# Fixes:

# Unsafe Permissions on .gnupg
# Source: https://superuser.com/a/954536
# chown -R $(whoami) ~/.gnupg/
# find ~/.gnupg -type f -exec chmod 600 {} \;
# find ~/.gnupg -type d -exec chmod 700 {} \;

{
    description = "A simple NixOS flake.";

    inputs = {
    	nixpkgs.url = "github:NixOs/nixpkgs/nixos-24.11";
	home-manager = {
	    url = "github:nix-community/home-manager/release-24.11";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
        nur.url = "github:nix-community/nur";
        swww = {
            url = "github:LGFae/swww";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    
    outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
        system = "x86_64-linux";
        mksystem = import ./lib/mksystem.nix {
            inherit nixpkgs inputs;
        };
        pkgs = import nixpkgs {
            inherit system;
        };
    in {
        devShells."${system}" = let 
            shellHook = "exec zsh";
        in {
            minecraft-mod = with pkgs; mkShell rec {
                buildInputs = [
                    xorg.libX11
                    xorg.libXcursor
                    xorg.libXrandr
                    xorg.libXxf86vm
                    xorg.libXext
                    flite
                    libusb1
                    libxkbcommon
                    wayland
                    egl-wayland
                    libGL
                    libpulseaudio
                    openal
                    vulkan-loader
                    gradle
                ];
                inherit shellHook;
                LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
            };
            rust = with pkgs; mkShell rec {
                buildInputs = [
                    cargo
                    rustc
                ];
                inherit shellHook;
                LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
            };
            rust-bevy = pkgs.mkShell rec {
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
                    libexif
                ];
                inherit shellHook;
                LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
            };
            rust-pi = let
                arm = import nixpkgs {
                    crossSystem = pkgs.lib.systems.examples.raspberryPi;
                    inherit system;
                };
            in pkgs.mkShell rec {
                buildInputs = [
                    arm.stdenv.cc
                ];
                inherit shellHook;
                LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
            };
            node22 = pkgs.mkShell {
                buildInputs = with pkgs; [
                    nodejs_22
                    yarn
                    firebase-tools
                ];
                inherit shellHook;
            };
        };

        nixosConfigurations = {
            pink-nixos-desktop = mksystem "pink-nixos-desktop" {
                user = "pink";
                inherit system;
                bluetooth = true;
                amdGraphics = true;
                vmware = true;
                vr = true;
                drive = true;
            };
            pink-nixos-laptop = mksystem "pink-nixos-laptop" {
                user = "pink";
                inherit system;
                bluetooth = true;
                battery = true;
                monitorBacklight = true;
                fingerprint = true;
            };
        };
    };
}
