{
    pkgs,
    config,
    ...
}: {
    programs.gamemode = {
        enable = true;
        settings.general.inhibit_screensaver = 0;
    };

    programs.gamescope = {
        enable = false;
        capSysNice = true;
    };

    programs.steam = {
        package = pkgs.steam.override {
            extraPkgs = pkgs:
                with pkgs; [
                    xorg.libXcursor
                    xorg.libXi
                    xorg.libXinerama
                    xorg.libXScrnSaver
                    libpng
                    libpulseaudio
                    libvorbis
                    stdenv.cc.cc.lib
                    libkrb5
                    keyutils
                    gamescope
                    mangohud
                    gamemode
                ];
        };
        gamescopeSession = {
            enable = config.programs.gamescope.enable;
            args = [
                "--expose-wayland"
                "--backend wayland"
                "--mango-app"
                "--steam"
                "--adaptive-sync"
            ];
        };
    };
}
