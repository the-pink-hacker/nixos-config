{
    pkgs,
    lib,
    monitorBacklight,
    inputs,
    theme,
    systemName,
    ...
}: let
    isLaptop = systemName == "pink-nixos-laptop";
in {
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

    environment.sessionVariables = lib.mkMerge [
        {
            NIXOS_OZONE_WL = "1";
            SDL_VIDEODRIVER = "wayland";
            HYPRCURSOR_THEME = theme.cursor.name;
            HYPRCURSOR_SIZE = theme.cursor.size;
        }
        (lib.mkIf isLaptop {
            GDK_SCALE = "1.175";
        })
    ];

    environment.systemPackages = with pkgs; [
        inputs.swww.packages.${pkgs.stdenv.hostPlatform.system}.swww
        gdk-pixbuf
        jq
        pango
        cairo
        networkmanagerapplet
        hyprshot
        candy-icons
        kdePackages.ktorrent
        kdePackages.kdenlive
        kdePackages.filelight
        kdePackages.polkit-qt-1
        #kdePackages.polkit-kde-agent-1
        kdePackages.kirigami
        kdePackages.kirigami-addons
        kdePackages.kirigami-gallery
        kdePackages.kquickcharts
        adwaita-icon-theme
        adwaita-qt
        adwaita-qt6
        gnome-themes-extra
        sweet
        hyprcursor
        kdePackages.breeze
        kdePackages.breeze-gtk
        playerctl
        pavucontrol
        jmtpfs
        hyprpolkitagent
    ];

    hardware.brillo.enable = monitorBacklight;

    qt = {
        enable = true;
        platformTheme = theme.qt.platformTheme.name;
        style = theme.qt.style.name;
    };

    services = {
        gnome.gnome-keyring.enable = true;
        displayManager = {
            defaultSession = "hyprland";
            sddm = {
                enable = true;
                wayland.enable = true;
                autoNumlock = true;
            };
        };
        desktopManager.plasma6.enable = true;
        gvfs.enable = true;
        udev.packages = [pkgs.libmtp.out];
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

    #systemd.user.services.polkit-kde-agent-1 = {
    #    description = "polkit-kde-agent-1";
    #    wantedBy = ["graphical-session.target"];
    #    wants = ["graphical-session.target"];
    #    after = ["graphical-session.target"];
    #    serviceConfig = {
    #        Type = "simple";
    #        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
    #        Restart = "on-failure";
    #        RestartSec = 1;
    #        TimeoutStopSec = 10;
    #    };
    #};

    #security.polkit.extraConfig = ''
    #    polkit.addRule(function(action, subject) {
    #        if (
    #            subject.isInGroup("users")
    #                && (
    #                    action.id == "org.freedesktop.login1.reboot" ||
    #                    action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
    #                    action.id == "org.freedesktop.login1.power-off" ||
    #                    action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
    #                    action.id == "io.systemd.mount-file-system.mount-image"
    #                )
    #            )
    #        {
    #            return polkit.Result.YES;
    #        }
    #    });
    #'';

    programs.dconf.enable = true;
}
