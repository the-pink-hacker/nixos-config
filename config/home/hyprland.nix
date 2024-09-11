{ pkgs, lib, globalUIScale, monitorBacklight, ... }:

let
    theme = "Sweet";
    iconTheme = "Sweet";
    cursorTheme = "catppuccin-macchiato-dark-cursors";
    cursorSize = 24;
in
{
    imports = [
        ./kitty.nix
        ./waybar.nix
    ];

    # Hint Electron applications to use Wayland
    home.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        XDG_PICTURES_DIR = "$HOME/Pictures";
        HYPRCURSOR_THEME = cursorTheme;
        HYPRCURSOR_SIZE = cursorSize;
    };

    qt = {
        enable = true;
        platformTheme.name = "kde";
        style = {
            package = pkgs.utterly-round-plasma-style;
            name = "Utterly Round";
        };
    };

    # Cursor setup
    home.pointerCursor = {
        name = cursorTheme;
        package = pkgs.catppuccin-cursors.macchiatoDark;
        gtk.enable = true;
        size = cursorSize;
    };
    
    # GTK Setup
    gtk = {
        enable = true;
        theme.name = theme;
        iconTheme.name = iconTheme;
        cursorTheme = {
            size = cursorSize;
            name = cursorTheme;
        };
        gtk3 = {
            bookmarks = [
              "file:///tmp"
            ];
            extraConfig.gtk-application-prefer-dark-theme = true;
        };
    };
    dconf.settings."org/gtk/settings/file-chooser" = {
        sort-directories-first = true;
    };
    
    # GTK4 Setup
    dconf.settings."org/gnome/desktop/interface" = {
        gtk-theme = lib.mkForce "Sweet";
        color-scheme = "prefer-dark";
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
            # Repeat
            binde = [
                (if monitorBacklight then ", XF86MonBrightnessUp, exec, brillo -A 5" else {})
                (if monitorBacklight then ", XF86MonBrightnessDown, exec, brillo -U 5" else {})
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
                ", XF86AudioPrev, exec, playerctl previous"
                ", XF86AudioNext, exec, playerctl next"
            ];
            monitor = ", preferred, auto, ${toString globalUIScale}";
        };
    };
}
