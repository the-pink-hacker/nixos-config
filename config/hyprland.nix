{ pkgs, ... }:

{
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
        kitty
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
