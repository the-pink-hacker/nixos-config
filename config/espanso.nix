{ pkgs, unstable, ... }:

{
    services.espanso = {
        enable = true;
        # UNSTABLE: Fix crash on startup
        package = unstable.espanso-wayland;
        configs = {
            default = {
                keyboard_layout = {
                    layout = "us";
                    rules = "evdev";
                    model = "pc105";
                };
            };
        };
        matches = {
            default = import ./espanso/default.nix;
        };
    };
}
