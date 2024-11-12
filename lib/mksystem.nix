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
    vmware ? false,
    vr ? false
}:

let
    systemName = name;
    machinePath = ../machine/${name};
    userPath = ../user/${user};
    extraArgs = {
        inherit inputs;
        inherit monitorBacklight;
        inherit battery;
        inherit system;
        inherit systemName;
        inherit user;
        inherit vr;
        inherit vmware;
    };
    lib = nixpkgs.lib;
in lib.nixosSystem rec {
    inherit system;
    specialArgs = extraArgs // {
        configPath = ../config;
    };
    modules = [
        { nixpkgs.config.allowUnfree = true; }

        { nixpkgs.overlays = [ inputs.nur.overlay ]; }

        { networking.hostName = name; }

        (if amdGraphics then ../hardware/amd.nix else {})
        (if nvidiaGraphics then ../hardware/nvidia.nix else {})
        (if bluetooth then ../hardware/bluetooth.nix else {})
        (if fingerprint then ../hardware/fingerprint.nix else {})

        (machinePath + /hardware.nix)
        (machinePath + /hardware-generated.nix)

        (userPath + /config.nix)

        inputs.home-manager.nixosModules.home-manager {
            home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = extraArgs // {
                    homeConfigPath = ../config/home;
                };
                users.${user} = import (userPath + /home.nix);
            };
        }
    ];
}
