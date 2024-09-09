{ ... }:

{
    # Hint Electron applications to use Wayland
    home.sessionVariables.NIXOS_OZONE_WL = "1";

    wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = builtins.readFile ./hyprland/default.conf;
        settings = {
            "$mod" = "SUPER";
            bind = [
                "$mod, F, exec, firefox"
            ];
        };
    };
}
