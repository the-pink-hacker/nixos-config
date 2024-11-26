{ pkgs, lib, monitorBacklight, systemName, config, ... }:

let
    theme = "Sweet-Dark";
    iconTheme = "Sweet";
    cursorTheme = "catppuccin-macchiato-dark-cursors";
    cursorPackage = pkgs.catppuccin-cursors.macchiatoDark;
    cursorSize = 24;
    isLaptop = systemName == "pink-nixos-laptop";
    isDesktop = systemName == "pink-nixos-desktop";
in
{
    imports = [
        ./kitty.nix
        ./waybar.nix
        ./mako.nix
    ];

    xdg = {
        userDirs = {
            enable = true;
            createDirectories = true;
        };
        configFile."kdeglobals".source = ./kde/kdeglobals;
    };

    home = {
        sessionVariables = {
            NIXOS_OZONE_WL = "1";
            HYPRCURSOR_THEME = cursorTheme;
            HYPRCURSOR_SIZE = cursorSize;
        };
    };

    qt = {
        enable = true;
        platformTheme.name = "kde";
        style = {
            package = pkgs.utterly-round-plasma-style;
            name = "breeze";
        };
    };

    # Cursor setup
    home.pointerCursor = {
        name = cursorTheme;
        package = cursorPackage;
        gtk.enable = true;
        size = cursorSize;
    };
    
    # GTK Setup
    gtk = {
        enable = true;
        theme.name = theme;
        iconTheme.name = iconTheme;
        gtk3 = {
            bookmarks = builtins.map (path: "file://" + path) (with config.xdg.userDirs; [
                desktop
                documents
                download
                music
                pictures
                publicShare
                templates
                videos
            ]);
            extraConfig.gtk-application-prefer-dark-theme = true;
        };
    };
    dconf.settings."org/gtk/settings/file-chooser" = {
        sort-directories-first = true;
    };
    
    # GTK4 Setup
    dconf.settings."org/gnome/desktop/interface" = {
        gtk-theme = lib.mkForce theme;
        color-scheme = "prefer-dark";
    };

    services.batsignal.enable = true;

    wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = builtins.readFile ./hyprland/default.conf;
        settings = {
            "$mainMod" = "SUPER";
            "$shiftMod" = "SUPER_SHIFT";
            exec-once = [
                "swww-daemon & swww restore"
                "exec nm-applet --indicator"
                "exec mako"
                "exec systemctl --user start plasma-polkit-agent"
                "exec kdeconnectd"
            ];
            exec = [
                "swww img ${../../assets/wallpaper.png}"
            ];
            misc.disable_hyprland_logo = true;
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
                "DP-2, preferred, auto-left, 1"
                "HDMI-A-1, disabled"
                "HDMI-A-2, preferred, auto-right, 1, vrr, 1"
            ]
            ++ lib.optional isLaptop "eDP-1, preferred, auto, 1.175";
        };
    };
}
