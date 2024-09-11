{ battery, lib, ... }:

{
    programs.waybar = {
        enable = true;
        systemd.enable = true;
        # Broken
        # Throws json value error
        #settings = {};
    };

    xdg.configFile."waybar/config".text = builtins.toJSON {
        position = "top";
        height = 30;
        spacing = 4;
        reload_style_on_change = true;
        modules-left = [
            "clock"
            "custom/media"
        ];
        modules-center = [
            "mpd"
            "idle_inhibitor"
            "pulseaudio"
            "network"
            "power-profiles-daemon"
            "cpu"
            "memory"
            "temperature"
            #"backlight"
            "keyboard-state"
            (lib.mkIf battery "battery")
            (lib.mkIf battery "battery#bat2")
        ];
        modules-right = [
            "tray"
            "custom/power"
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
        "mpd" = {
            "format" = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
            "format-disconnected" = "Disconnected ";
            "format-stopped" = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
            "unknown-tag" = "N/A";
            "interval" = 5;
            "consume-icons" = {
                "on" = " ";
            };
            "random-icons" = {
                "off" = "<span color=\"#f53c3c\"></span> ";
                "on" = " ";
            };
            "repeat-icons" = {
                "on" = " ";
            };
            "single-icons" = {
                "on" = "1 ";
            };
            "state-icons" = {
                "paused" = "";
                "playing" = "";
            };
            "tooltip-format" = "MPD (connected)";
            "tooltip-format-disconnected" = "MPD (disconnected)";
        };
        "idle_inhibitor" = {
            "format" = "{icon}";
            "format-icons" = {
                "activated" = "";
                "deactivated" = "";
            };
        };
        "tray" = {
            # "icon-size" = 21;
            "spacing" = 10;
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
            # "thermal-zone" = 2;
            # "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
            "critical-threshold" = 80;
            "format" = "{temperatureC}°C {icon}";
            "format-icons" = ["" "" ""];
        };
        # Refused to work with backlight
        #backlight = {
        #    format = "{percent}% {icon}";
        #    format-icons = ["" "" "" "" "" "" "" "" ""];
        #};
        "battery" = lib.mkIf battery {
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
            # "format-good" = ""; # An empty format will hide the module
            # "format-full" = "";
            "format-icons" = ["" "" "" "" ""];
        };
        "battery#bat2" = lib.mkIf battery {
            "bat" = "BAT2";
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
            # "interface" = "wlp2*"; # (Optional) To force the use of this interface
            "format-wifi" = "{essid} ({signalStrength}%) ";
            "format-ethernet" = "{ipaddr}/{cidr} ";
            "tooltip-format" = "{ifname} via {gwaddr} ";
            "format-linked" = "{ifname} (No IP) ";
            "format-disconnected" = "Disconnected ⚠";
            "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
        pulseaudio = {
            scroll-step = 2; # % can be a float
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
        "custom/media" = {
            "format" = "{icon} {}";
            "return-type" = "json";
            "max-length" = 40;
            "format-icons" = {
                "spotify" = "";
                "default" = "🎜";
            };
            "escape" = true;
            "exec" = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
        };
        "custom/power" = {
            "format"  = "⏻ ";
            "tooltip" = false;
            "menu" = "on-click";
            "menu-file" = "$HOME/.config/waybar/power_menu.xml";
            "menu-actions" = {
                "shutdown" = "shutdown";
                "reboot" = "reboot";
                "suspend" = "systemctl suspend";
                "hibernate" = "systemctl hibernate";
            };
        };
    };
}