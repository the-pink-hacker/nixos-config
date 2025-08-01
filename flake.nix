# Fixes:

# Unsafe Permissions on .gnupg
# Source: https://superuser.com/a/954536
# chown -R $(whoami) ~/.gnupg/
# find ~/.gnupg -type f -exec chmod 600 {} \;
# find ~/.gnupg -type d -exec chmod 700 {} \;

{
    description = "A simple NixOS flake.";

    inputs = {
    	nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.05";
	home-manager = {
	    url = "github:nix-community/home-manager/release-25.05";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
        nur.url = "github:nix-community/nur";
        swww = {
            url = "github:LGFae/swww";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        rust-overlay = {
            url = "github:oxalica/rust-overlay";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-minecraft = {
            url = "github:Infinidoge/nix-minecraft";
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
            overlays = [
                (import inputs.rust-overlay)
            ];
        };
        theme = import ./config/theme.nix { inherit pkgs; };
    in {
        devShells."${system}" = let 
            shellHook = "exec fish";
        in {
            rust = with pkgs; mkShell rec {
                buildInputs = [
                    (rust-bin.stable.latest.default.override {
                        extensions = [
                            "rust-analyzer"
                            "rust-src"
                        ];
                    })
                    pkg-config
                    openssl
                ];
                inherit shellHook;
                LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
            };
            rust-bevy = pkgs.mkShell rec {
                buildInputs = with pkgs; [
                    (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
                        extensions = [
                            "rust-analyzer"
                            "rust-src"
                        ];
                    }))
                    pkg-config
                    mold
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
                    openssl
                    cargo-edit
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
                #vmware = true;
                vr = false;
                drive = true;
                inherit theme;
            };
            pink-nixos-laptop = mksystem "pink-nixos-laptop" {
                user = "pink";
                inherit system;
                bluetooth = true;
                battery = true;
                monitorBacklight = true;
                fingerprint = true;
                inherit theme;
            };
            pink-nixos-optiplex = mksystem "pink-nixos-optiplex" {
                user = "pink";
                inherit system;
                inherit theme;
                gui = false;
                drive = true;
            };
        };
    };
}
