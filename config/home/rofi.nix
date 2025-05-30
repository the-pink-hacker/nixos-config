{ pkgs, config, ... }:

{
    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        pass = {
            enable = true;
            package = pkgs.rofi-pass-wayland;
        };
    };
}
