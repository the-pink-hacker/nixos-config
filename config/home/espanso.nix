{ pkgs, ... }:

{
    services.espanso = {
        enable = true;
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
