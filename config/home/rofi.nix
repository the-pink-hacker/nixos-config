{
    pkgs,
    config,
    ...
}: {
    programs.rofi = {
        enable = true;
        package = pkgs.rofi;
        plugins = with pkgs; [
            rofi-emoji
            rofi-calc
            rofi-pass
        ];
        pass = {
            enable = true;
            package = pkgs.rofi-pass;
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
        "$mainMod, S, exec, rofi -show drun -show-icons -sort"
        "$mainMod, period, exec, rofi -show emoji"
    ];
}
