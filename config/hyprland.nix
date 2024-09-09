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
    ];

    services.displayManager.sddm = {
    	enable = true;
	wayland.enable = true;
    };

    xdg.portal.extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
    ];

    security.polkit.enable = true;

    programs.dconf.enable = true;
}
