{ nixpkgs, inputs }:

name:

{
    user,
    system,
    bluetooth ? false,
    amdGraphics ? false,
    nvidiaGraphics ? false,
    globalUIScale ? 1.0,
    battery ? false,
    monitorBacklight ? false,
    fingerprint ? false
}:

nixpkgs.lib.nixosSystem rec {
    inherit system;
    modules = [
        { nixpkgs.config.allowUnfree = true; }

        { networking.hostName = system; }

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
                    inherit inputs system globalUIScale battery monitorBacklight;
                };
                users.${user} = import ../user/${user}/home.nix;
            };
        }

        {
            config._module.args = {
                inherit inputs;
                inherit monitorBacklight;
                inherit battery;
                inherit system;
            };
        }
    ];
}
