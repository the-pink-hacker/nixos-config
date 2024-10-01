{ pkgs, monitorBacklight, ... }:

{
    programs = {
        hyprland.enable = true;
        kde-pim.enable = true;
        thunar = {
            enable = true;
            plugins = with pkgs.xfce; [
                thunar-archive-plugin
                thunar-media-tags-plugin
                thunar-volman
            ];
        };
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
        #kdePackages.breeze-icons
        #kdePackages.kwalletmanager
        #kdePackages.gwenview
        #kdePackages.qtwayland
        #kdePackages.qtsvg
        #kdePackages.ffmpegthumbs
        #kdePackages.kdegraphics-thumbnailers
        #kdePackages.kdesdk-thumbnailers
        #kdePackages.kimageformats
        #kdePackages.qtimageformats
        #kdePackages.taglib
        #kdePackages.kio
        #kdePackages.kdf
        #kdePackages.kio-admin
        #kdePackages.qtwayland
        #kdePackages.plasma-integration
        #kdePackages.kservice
        #kdePackages.kdf
        #kdePackages.ark
        #kdePackages.ksvg
        #kdePackages.kgpg
        #kdePackages.wayqt
        #kdePackages.kmime
        #kdePackages.svgpart
        kdePackages.ktorrent
        kdePackages.kdenlive
        #kdePackages.dolphin-plugins
        kdePackages.filelight
        #kdePackages.kio-gdrive
        #kdePackages.kio-fuse
        #kdePackages.kio-extras
        #kdePackages.polkit-kde-agent-1
        #shared-mime-info
        #resvg
        #libheif
        kdePackages.kirigami
        sweet
        hyprcursor
        playerctl
        pavucontrol
        jmtpfs
    ];

    hardware.brillo.enable = monitorBacklight;

    services = {
        #gnome.gnome-keyring.enable = true;
        displayManager.sddm = {
            enable = true;
            wayland.enable = true;
        };
        desktopManager.plasma6.enable = true;
        gvfs.enable = true;
        udev.packages = [ pkgs.libmtp.out ];
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
            #login = {
            #    enableGnomeKeyring = true;
            #    kwallet.enable = true;
            #};
            #kdewallet.kwallet.enable = true;
        };
    };

    systemd.user.services.polkit-kde-agent-1 = {
        description = "polkit-kde-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
        };
    };

    security.polkit.extraConfig = ''
        polkit.addRule(function(action, subject) {
            if (
                subject.isInGroup("users")
                    && (
                        action.id == "org.freedesktop.login1.reboot" ||
                        action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                        action.id == "org.freedesktop.login1.power-off" ||
                        action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
                        action.id == "io.systemd.mount-file-system.mount-image"
                    )
                )
            {
                return polkit.Result.YES;
            }
        });
    '';

    programs.dconf.enable = true;
}
