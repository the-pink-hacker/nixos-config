{ pkgs, ... }:

{
    imports = [
        ./kitty.nix
    ];

    # Hint Electron applications to use Wayland
    home.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        XDG_PICTURES_DIR = "$HOME/Pictures";
    };

    qt = {
        enable = true;
        platformTheme = "kde";
        style = {
            package = pkgs.utterly-round-plasma-style;
            name = "Utterly Round";
        };
    };

    wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = builtins.readFile ./hyprland/default.conf;
        settings = {
            "$mainMod" = "SUPER";
            "$shiftMod" = "SUPER_SHIFT";
            "exec-once" = [
                ''exec swww-daemon & exec sww img "~/Pictures/background-1 v2.png"''
                "exec nm-applet --indicator"
                "exec waybar"
                "exec mako"
            ];
            bind = [
                "$mainMod, F, exec, firefox"
                "$mainMod, S, exec, rofi -show drun -show-icons"
                # Screenshot a window
                "$mainMod, Print, exec, hyprshot -m window"
                # Screenshot a monitor
                ", PRINT, exec, hyprshot -m output"
                # Screenshot a region
                "$shiftMod, Print, exec, hyprshot -m region"
            ];
            monitor = ", preferred, auto, 1.175";
        };
    };
}
