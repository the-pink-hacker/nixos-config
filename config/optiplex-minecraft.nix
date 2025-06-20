{ inputs, config, ... }:

let 
    pkgs = import inputs.nixpkgs {
        inherit (config.nixpkgs) system;
        overlays = [ inputs.nix-minecraft.overlay ];
        config.allowUnfree = true;
    };
    inherit (inputs.nix-minecraft.lib) collectFilesAt;
in {
    services.minecraft-servers = {
        enable = true;
        eula = true;
        openFirewall = true;
        servers.optiplex = {
            enable = true;
            autoStart = true;
            package = pkgs.fabricServers.fabric-1_21_6.override {
                loaderVersion = "0.16.14";
            };
            restart = "always";
            #enableReload = true;
            whitelist = {
                ThePinkHacker = "a0893fac-b70f-45ca-8901-eea269c6b444";
                HazardousSole54 = "5f96d607-d822-4eae-8b23-7cfef3799039";
            };
            operators = {
                ThePinkHacker = {
                    uuid = "a0893fac-b70f-45ca-8901-eea269c6b444";
                    bypassesPlayerLimit = true;
                };
            };
            serverProperties = {
                accepts-transfers = false;
                allow-flight = false;
                allow-nether = true;
                broadcast-console-to-ops = true;
                broadcast-rcon-to-ops = true;
                #bug-report-link = ;
                difficulty = "hard";
                enable-command-block = false;
                enable-jmx-monitoring = false;
                enable-query = false;
                enable-rcon = false;
                enable-status = true;
                enforce-secure-profile = true;
                enforce-whitelist = true;
                entity-broadcast-range-percentage = 100;
                force-gamemode = false;
                function-permission-level = 2;
                gamemode = "survival";
                generate-structures = true;
                #generator-settings = {};
                hardcore = false;
                hide-online-players = true;
                #initial-disabled-packs = ;
                initial-enabled-packs = "vanilla";
                level-name = "main";
                #level-seed = ;
                level-type = "minecraft:normal";
                log-ips = true;
                max-chained-neighbor-updates = 1000000;
                max-players = 20;
                max-tick-time = 60000;
                max-world-size = 29999984;
                motd = "Pink's Server";
                network-compression-threshold = 256;
                online-mode = true;
                op-permission-level = 4;
                pause-when-empty-seconds = 60;
                player-idle-timeout = 0;
                prevent-proxy-connections = false;
                pvp = true;
                "query.port" = 25565;
                rate-limit = 0;
                #rcon.password = ;
                "rcon.port" = 25575;
                region-file-compression = "deflate";
                require-resource-pack = false;
                #resource-pack = ;
                #resource-pack-id = ;
                #resource-pack-prompt = ;
                #resource-pack-sha1 = ;
                #server-ip = ;
                server-port = 25565;
                simulation-distance = 10;
                spawn-monsters = true;
                spawn-protection = 16;
                sync-chunk-writes = true;
                #text-filtering-config = ;
                text-filtering-version = 0;
                use-native-transport = true;
                view-distance = 12;
                white-list = true;
            };
        };
    };
}
