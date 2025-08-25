{...}: {
    wayland.windowManager.hyprland.settings."$terminal" = "urxvt";

    programs.urxvt = {
        enable = true;
        iso14755 = true;
        keybindings = {
            Shift-Control-C = "eval:selection_to_clipboard";
            Shift-Control-V = "eval:paste_clipboard";
        };
        scroll = {
            lines = 8192;
            bar = {
                align = "bottom";
                floating = true;
            };
        };
        fonts = [
            "xft:Meslo LG L DZ for Powerline:size=10"
        ];
        extraConfig = rec {
            visualBell = false;

            # Theme
            background = "#000000";
            foreground = "gray90";
            color7 = foreground;
            colorBD = "#ffffff";
            cursorColor = "#f0f0f0";
            throughColor = "#8080f0";
            highlightColor = "#f0f0f0";
        };
    };
}
