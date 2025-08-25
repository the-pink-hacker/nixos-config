{
    pkgs,
    theme,
    ...
}: {
    home.packages = with pkgs; [
        kitty
    ];

    wayland.windowManager.hyprland.settings."$terminal" = "kitty";

    programs.rofi.terminal = "${pkgs.kitty}/bin/kitty";

    programs.kitty = {
        enable = true;
        font = {
            name = theme.fonts.monospace.name;
            size = theme.fonts.monospace.defaultSize;
        };
        settings = {
            shell = "fish";
        };
        themeFile = theme.programs.kitty.themeFile;
    };
}
