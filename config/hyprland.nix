{ pkgs, monitorBacklight, inputs, ... }:

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
        inputs.swww.packages.${pkgs.system}.swww
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
        kdePackages.polkit-kde-agent-1
        kdePackages.kirigami
        kdePackages.kirigami-addons
        kdePackages.kirigami-gallery
        sweet
        hyprcursor
        playerctl
        pavucontrol
        jmtpfs
    ];

    hardware.brillo.enable = monitorBacklight;

    services = {
        gnome.gnome-keyring.enable = true;
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
