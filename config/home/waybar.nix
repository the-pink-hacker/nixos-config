{ battery, lib, ... }:

{
    programs.waybar = {
        enable = true;
        systemd.enable = true;
        style = ./waybar/style.css;
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
        ];
        modules-center = builtins.concatLists [
            [
                "pulseaudio"
                "network"
                "cpu"
                "memory"
                "temperature"
                "keyboard-state"
            ]
            (if battery then [
                "battery"
                "power-profiles-daemon"
            ] else [])
        ];
        modules-right = [
            "tray"
        ];
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
            format = "{:L%H:%M:%S}";
            format-alt = "{:L%Y-%m-%d}";
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
