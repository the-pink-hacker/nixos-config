{ pkgs, lib, monitorBacklight, systemName, config, theme, ... }:

let
    isLaptop = systemName == "pink-nixos-laptop";
    isDesktop = systemName == "pink-nixos-desktop";
in
{
    imports = [
        ./kitty.nix
        ./waybar.nix
        ./mako.nix
        ./rofi.nix
    ];

    xdg.configFile."kdeglobals".source = ./kde/kdeglobals;

    home = {
        sessionVariables = {
            NIXOS_OZONE_WL = "1";
            HYPRCURSOR_THEME = theme.cursor.name;
            HYPRCURSOR_SIZE = theme.cursor.size;
        };
    };

    qt = {
        enable = true;
        platformTheme.name = theme.qt.platformTheme.name;
        style = theme.qt.style;
    };

    # Cursor setup
    home.pointerCursor = {
        name = theme.cursor.name;
        package = theme.cursor.package;
        gtk.enable = true;
        size = theme.cursor.size;
    };
    
    # GTK Setup
    gtk = {
        enable = true;
        theme.name = theme.gtk.name;
        iconTheme.name = theme.icons.name;
        gtk3 = {
            bookmarks = map (path: "file://" + path) (with config.xdg.userDirs; [
                desktop
                documents
                download
                music
                pictures
                publicShare
                templates
                videos
            ]);
            extraConfig.gtk-application-prefer-dark-theme = theme.darkMode;
        };
    };
    dconf.settings."org/gtk/settings/file-chooser" = {
        sort-directories-first = true;
    };
    
    # GTK4 Setup
    dconf.settings."org/gnome/desktop/interface" = {
        gtk-theme = lib.mkForce theme.gtk.name;
        color-scheme = if theme.darkMode then "prefer-dark" else "prefer-light";
    };

    services.batsignal.enable = true;

    wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = builtins.readFile ./hyprland/default.conf;
        settings = {
            "$mainMod" = "SUPER";
            "$shiftMod" = "SUPER_SHIFT";
            "$fileManager" = "thunar";
            exec-once = [
                "swww-daemon & swww restore"
                "exec nm-applet --indicator"
                "exec mako"
                "exec systemctl --user start plasma-polkit-agent"
                "exec kdeconnectd"
            ];
            exec = [
                "swww img ${theme.wallpaper} -t none"
            ];
            misc.disable_hyprland_logo = true;
            # https://wiki.linuxquestions.org/wiki/XF86_keyboard_symbols
            # https://wiki.linuxquestions.org/wiki/List_of_Keysyms_Recognised_by_Xmodmap
            bind = [
                "$mainMod, F, exec, firefox"
                "$mainMod, S, exec, rofi -show drun -show-icons"
                # Screenshot a window
                "$mainMod, Print, exec, hyprshot -m window"
                # Screenshot a monitor
                ", PRINT, exec, hyprshot -m output"
                # Screenshot a region
                "$shiftMod, Print, exec, hyprshot -m region"
                # Emoji selector
                "$mainMod, period, exec, wofi-emoji"
            ];
            # Repeat
            binde = lib.optionals monitorBacklight [
                ", XF86MonBrightnessUp, exec, brillo -A 5"
                ", XF86MonBrightnessDown, exec, brillo -U 5"
            ];
            # Repeat Locked
            bindel = [
                ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
                ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
            ];
            # Locked
            bindl = [
                ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ", XF86AudioPlay, exec, playerctl play-pause"
                ", XF86AudioPlay, exec, mpc toggle"
                ", XF86AudioPrev, exec, playerctl previous"
                ", XF86AudioPrev, exec, mpc prev"
                ", XF86AudioNext, exec, playerctl next"
                ", XF86AudioNext, exec, mpc next"
            ];
            monitor = [
                ", preferred, auto, 1"
            ]
            ++ lib.optionals isDesktop [
                "DP-1, preferred, auto, 1, vrr, 1, bitdepth, 10"
                "DP-2, preferred, auto-right, 1, vrr, 1"
            ]
            ++ lib.optional isLaptop "eDP-1, preferred, auto, 1.175";
            # https://wiki.hyprland.org/Configuring/Variables/#general
            general = {
                resize_on_border = false;
                allow_tearing = false;
                layout = "dwindle";
                gaps_in = theme.desktop.gaps_in;
                gaps_out = theme.desktop.gaps_out;
                border_size = theme.desktop.border_size;
                "col.active_border" = "rgba(${theme.desktop.active_border.color.rgba_hex})";
                "col.inactive_border" = "rgba(${theme.desktop.inactive_border.color.rgba_hex})";
            };
            # https://wiki.hyprland.org/Configuring/Variables/#decoration
            decoration = {
                rounding = theme.desktop.border_radius;
                active_opacity = 1.0;
                inactive_opacity = 1.0;
                #drop_shadow = true
                #shadow_range = 4
                #shadow_render_power = 3
                #col.shadow = rgba(1a1a1aee)
                # https://wiki.hyprland.org/Configuring/Variables/#blur
                blur = {
                    enabled = true;
                    size = 3;
                    passes = 1;
                    vibrancy = 0.1696;
                };
            };
        };
    };
}
