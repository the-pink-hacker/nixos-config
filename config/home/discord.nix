{pkgs, ...}: {
    home.packages = [pkgs.discord];

    xdg.configFile."discord/settings.json".source = ./discord/settings.json;

    services.mpd-discord-rpc.enable = true;

    xdg.desktopEntries = {
        discord = {
            name = "Discord";
            genericName = "Instant Messenger";
            exec = "Discord --enable-features=UseOzonePlatform,WaylandWindoDecorations,WebRTCPipeWireCapture --ozone-platform=wayland";
            categories = ["Network" "InstantMessaging"];
            comment = "All-in-one cross-platform voice and text chat for gamers";
            icon = "discord";
            terminal = false;
            type = "Application";
            mimeType = ["x-scheme-handler/discord"];
        };
    };
}
