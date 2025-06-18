{ pkgs }:

let
    mkcolor = import ../lib/mkcolor.nix;
    lib = pkgs.lib;
in {
    darkMode = true;
    cursor = {
        name = "catppuccin-macchiato-dark-cursors";
        package = pkgs.catppuccin-cursors.macchiatoDark;
        size = 24;
    };
    gtk.name = "Sweet-Dark";
    icons.name = "Sweet";
    qt = {
        platformTheme.name = "kde6";
        style = {
            package = pkgs.utterly-round-plasma-style;
            name = "breeze";
        };
    };
    fonts = {
        monospace = {
            name = "Meslo LG L DZ for Powerline";
            package = pkgs.powerline-fonts;
            defaultSize = 10;
        };
    };
    wallpaper = ../assets/wallpaper.png;
    programs.kitty.themeFile = "Solarized_Dark_Higher_Contrast";
    desktop = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        border_radius = 8;
        text.color = mkcolor {
            red = 217;
            green = 154;
            blue = 240;
            inherit lib;
        };
        active_border.color = mkcolor {
            red = 51;
            green = 204;
            blue = 255;
            alpha = 14.0 / 15.0;
            inherit lib;
        };
        inactive_border.color = mkcolor {
            red = 89;
            green = 89;
            blue = 89;
            alpha = 1.0 / 3.0;
            inherit lib;
        };
    };
}
