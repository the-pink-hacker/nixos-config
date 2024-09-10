{ pkgs, ... }:

{
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
        waybar
        rofi-wayland
        swww
        gdk-pixbuf
        jq
        pango
        cairo
        mako
        networkmanagerapplet
        hyprshot
        candy-icons
    ];

    services.displayManager.sddm = {
    	enable = true;
	wayland.enable = true;
    };

    xdg = {
        icons.enable = true;
        portal.extraPortals = with pkgs; [
            xdg-desktop-portal-hyprland
        ];
    };

    security.polkit.enable = true;

    programs.dconf.enable = true;
}
