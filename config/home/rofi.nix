{ pkgs, config, ... }:

{
    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        plugins = with pkgs; [
            rofi-emoji-wayland
            (rofi-calc.override {
                rofi-unwrapped = pkgs.rofi-wayland-unwrapped;
            })
            rofi-pass-wayland
        ];
        pass = {
            enable = true;
            package = pkgs.rofi-pass-wayland;
        };
        theme = "solarized";
        extraConfig = {
            modes = [
                "drun"
                "calc"
                "combi"
                "emoji"
                "window"
                "run"
                "keys"
            ];
        };
    };
    
    wayland.windowManager.hyprland.settings.bind = [
        "$mainMod, S, exec, rofi -show drun -show-icons"
        "$mainMod, period, exec, rofi -show emoji"
    ];
}
