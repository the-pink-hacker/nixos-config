{
    battery,
    lib,
    theme,
    ...
}: let
    style_file = ./waybar/style.css;
    style_from = [
        "THEME_TEXT_COLOR"
        "THEME_BORDER_RADIUS"
    ];
    style_to = [
        theme.desktop.text.color.rgba
        (toString theme.desktop.border_radius)
    ];
    style = lib.replaceStrings style_from style_to (builtins.readFile style_file);
in {
    programs.waybar = {
        enable = true;
        systemd.enable = true;
        inherit style;
        # Broken
        # Throws json value error
        #settings = {};
    };

    xdg.configFile."waybar/config".text = builtins.toJSON {
        position = "top";
        height = 32;
        spacing = 4;
        reload_style_on_change = true;
        modules-left = [
            "clock"
            "mpd"
        ];
        modules-center =
            [
                "pulseaudio"
                "network"
                "cpu"
                "memory"
                "temperature"
                "keyboard-state"
            ]
            ++ lib.optionals battery [
                "battery"
                "power-profiles-daemon"
            ];
        modules-right = [
            "tray"
        ];
        mpd = {
            on-click = "kitty ncmpcpp";
            format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} | {album} | {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S})";
            format-disconnected = "Disconnected ";
            format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
            album-len = 20;
            interval = 10;
            consume-icons = {
                on = " ";
            };
            random-icons = {
                off = "<span color=\"#f53c3c\"></span> ";
                on = " ";
            };
            repeat-icons = {
                on = " ";
            };
            single-icons = {
                on = "1 ";
            };
            state-icons = {
                paused = "";
                playing = "";
            };
            tooltip-format = "MPD (connected)";
            tooltip-format-disconnected = "MPD (disconnected)";
        };
        "keyboard-state" = {
            "numlock" = true;
            "capslock" = true;
            "format" = "{name} {icon}";
            "format-icons" = {
                "locked" = "";
                "unlocked" = "";
            };
        };
        tray = {
            spacing = 10;
        };
        clock = {
            tooltip-format = "<big>{:L%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format = "{:%H:%M:%S }";
            format-alt = "{:%Y-%m-%d }";
            timezone = "America/Indiana/Indianapolis";
            interval = 1;
        };
        "cpu" = {
            "format" = "{usage}% ";
            "tooltip" = false;
        };
        "memory" = {
            "format" = "{}% ";
        };
        "temperature" = {
            "critical-threshold" = 80;
            "format" = "{temperatureC}°C {icon}";
            "format-icons" = ["" "" ""];
        };
        "battery" = {
            "states" = {
                "good" = 95;
                "warning" = 30;
                "critical" = 15;
            };
            "format" = "{capacity}% {icon}";
            "format-full" = "{capacity}% {icon}";
            "format-charging" = "{capacity}% ";
            "format-plugged" = "{capacity}% ";
            "format-alt" = "{time} {icon}";
            "format-icons" = ["" "" "" "" ""];
        };
        "power-profiles-daemon" = {
            "format" = "{icon}";
            "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
            "tooltip" = true;
            "format-icons" = {
                "default" = "";
                "performance" = "";
                "balanced" = "";
                "power-saver" = "";
            };
        };
        "network" = {
            "format-wifi" = "{essid} ({signalStrength}%) ";
            "format-ethernet" = "{ipaddr}/{cidr} ";
            "tooltip-format" = "{ifname} via {gwaddr} ";
            "format-linked" = "{ifname} (No IP) ";
            "format-disconnected" = "Disconnected ⚠";
            "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
        pulseaudio = {
            scroll-step = 2;
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = ["" "" ""];
            };
            on-click = "pavucontrol";
            reverse-scrolling = true;
        };
    };
}
