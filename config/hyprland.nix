{ pkgs, monitorBacklight, ... }:

{
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
        rofi-wayland
        swww
        gdk-pixbuf
        jq
        pango
        cairo
        networkmanagerapplet
        hyprshot
        candy-icons
        kdePackages.breeze-icons
        kdePackages.kwalletmanager
        kdePackages.gwenview
        kdePackages.kio-fuse
        kdePackages.kio-extras
        kdePackages.qtwayland
        kdePackages.qtsvg
        kdePackages.ffmpegthumbs
        kdePackages.kdegraphics-thumbnailers
        kdePackages.kdesdk-thumbnailers
        kdePackages.kimageformats
        kdePackages.qtimageformats
        kdePackages.taglib
        resvg
        libheif
        sweet
        hyprcursor
        playerctl
        pavucontrol
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
        pam.services = {
            "default keyring".enableGnomeKeyring = true;
            kdewallet.kwallet.enable = true;
        };
    };

    programs.dconf.enable = true;
}
