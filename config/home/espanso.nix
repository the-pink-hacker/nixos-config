{pkgs, ...}: {
    services.espanso = {
        package = pkgs.espanso.override {
            x11Support = false;
            waylandSupport = true;
        };
        enable = true;
        configs = {
            default = {
                show_icon = false;
                show_notifications = false;
            };
        };
        matches = {
            default = import ./espanso/default.nix;
        };
    };
}
