{ pkgs, ... }:

{
    home.packages = with pkgs; [
        kitty
    ];

    wayland.windowManager.hyprland.settings."$terminal" = "kitty";

    programs.kitty = {
        enable = true;
        font = {
            name = "Meslo LG L DZ for Powerline";
            size = 10;
        };
    };
}
