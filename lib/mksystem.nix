{ nixpkgs, inputs }:

name:

{
    user,
    system,
    bluetooth ? false,
    amdGraphics ? false,
    nvidiaGraphics ? false,
    battery ? false,
    monitorBacklight ? false,
    fingerprint ? false,
    vr ? false
}:

let
    systemName = name;
in nixpkgs.lib.nixosSystem rec {
    inherit system;
    modules = [
        { nixpkgs.config.allowUnfree = true; }

        { nixpkgs.overlays = [ inputs.nur.overlay ]; }

        { networking.hostName = name; }

        (if amdGraphics then ../hardware/amd.nix else {})
        (if nvidiaGraphics then ../hardware/nvidia.nix else {})
        (if bluetooth then ../hardware/bluetooth.nix else {})
        (if fingerprint then ../hardware/fingerprint.nix else {})

        ../machine/${name}/hardware.nix
        ../machine/${name}/hardware-generated.nix

        ../user/${user}/config.nix

        inputs.home-manager.nixosModules.home-manager {
            home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                    inherit inputs system battery monitorBacklight systemName user vr;
                };
                users.${user} = import ../user/${user}/home.nix;
            };
        }

        {
            config._module.args = {
                inherit inputs monitorBacklight battery system systemName user vr;
            };
        }
    ];
}
