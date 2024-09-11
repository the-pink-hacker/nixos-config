{ pkgs, monitorBacklight, ... }:

{
    programs = {
        hyprland.enable = true;
        waybar.enable = true;
    };

    environment.systemPackages = with pkgs; [
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
        kdePackages.breeze-icons
        kdePackages.kwalletmanager
        sweet
        hyprcursor
        playerctl
    ];

    hardware.brillo.enable = monitorBacklight;

    services = {
        gnome.gnome-keyring.enable = true;
        displayManager.sddm = {
            enable = true;
            wayland.enable = true;
        };
    };

    xdg = {
        icons.enable = true;
        portal.extraPortals = with pkgs; [
            xdg-desktop-portal-hyprland
        ];
    };

    security = {
        polkit.enable = true;
        pam.services.kdewallet.kwallet.enable = true;
    };

    programs.dconf.enable = true;
}
