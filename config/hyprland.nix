{ pkgs, monitorBacklight, ... }:

{
    imports = [
        ./hyprlock.nix
    ];

    programs = {
        hyprland.enable = true;
        kde-pim.enable = true;
    };

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
        kdePackages.kio
        kdePackages.kdf
        kdePackages.kio-admin
        kdePackages.qtwayland
        kdePackages.plasma-integration
        kdePackages.kservice
        kdePackages.dolphin-plugins
        kdePackages.kdf
        kdePackages.ark
        kdePackages.ksvg
        kdePackages.kgpg
        kdePackages.wayqt
        kdePackages.kmime
        kdePackages.svgpart
        kdePackages.ktorrent
        kdePackages.kdenlive
        kdePackages.filelight
        kdePackages.kio-gdrive
        shared-mime-info
        resvg
        libheif
        sweet
        hyprcursor
        playerctl
        pavucontrol
        jmtpfs
    ];

    hardware.brillo.enable = monitorBacklight;

    services = {
        gnome.gnome-keyring.enable = true;
        gvfs.enable = true;
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
            login = {
                enableGnomeKeyring = true;
                kwallet.enable = true;
            };
            kdewallet.kwallet.enable = true;
        };
    };

    programs.dconf.enable = true;
}
