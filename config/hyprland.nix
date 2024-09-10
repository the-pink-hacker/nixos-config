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
        kdePackages.breeze-icons
        kdePackages.kwalletmanager
        sweet
        hyprcursor
    ];

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
