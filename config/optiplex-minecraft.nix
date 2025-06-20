{ inputs, config, ... }:

let 
    pkgs = import inputs.nixpkgs {
        inherit (config.nixpkgs) system;
        overlays = [ inputs.nix-minecraft.overlay ];
        config.allowUnfree = true;
    };
    inherit (inputs.nix-minecraft.lib) collectFilesAt;
    inherit (builtins) fetchurl;
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
            symlinks.mods = pkgs.linkFarmFromDrvs "mods" (
                builtins.attrValues {
                    # For netherportalfix
                    balm = fetchurl {
                        url = "https://cdn.modrinth.com/data/MBAkmtvl/versions/4arCr13S/balm-fabric-1.21.6-21.6.1.jar";
                        sha512 = "2ecf65ba78e353f46183223298031a896a5447d1495b74e95e4811907fb636faad018e77af03668522a315d3ee8a52527319fbabaae311e4812f95d4bfb5a273";
                    };
                    crashexploitfixer = fetchurl {
                        url = "https://cdn.modrinth.com/data/Z5GdSH3X/versions/ibSODuZ1/crashexploitfixer-fabric-1.2.0%2B1.21.5.jar";
                        sha512 = "0a1257b157070d9e4df4104b70e2e04aecfd90666dcab0a6efba9cfa38bc3342172ea1e06f186e7ebfdfa05b867662da1fb780c0dd98f443d3b3b8230d118a17";
                    };
                    fabric-api = fetchurl {
                        url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/N3z6cNQv/fabric-api-0.127.1%2B1.21.6.jar";
                        sha512 = "c7b4ea754a486193476b33ac4d1eaeb30b644e05b76a6abe8cf51ca4eb6832063d32293f1c9052c32c806712d26f85b531085a3ff52575021ee831a804167c4d";
                    };
                    netherportalfix = fetchurl {
                        url = "https://cdn.modrinth.com/data/nPZr02ET/versions/P3NCOkYd/netherportalfix-fabric-1.21.6-21.6.1.jar";
                        sha512 = "ce9cc3dec9c01725a2c28ea275ef9e96b3ce7822a63de4b6e9c9eb36fda4ebee4c8be233de9dbb214b7e1302801702b6c59efbf834be006debc5c205831b35e3";
                    };
                    scalablelux = fetchurl {
                        url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/vNOezq1q/ScalableLux-0.1.4%2Bfabric.b88b7b4-all.jar";
                        sha512 = "08519ef0071d269bd716fe6fe4f3d2e9e9ed11246db1f361928388cc8e4a4d4125cd0d9500e8b4328f9058cde64e54e66cea77a619f2dff03f654176a6b4c798";
                    };
                    slime = fetchurl {
                        url = "https://cdn.modrinth.com/data/qpnMRvwM/versions/bDOWNLz2/Slime-1.21.6.jar";
                        sha512 = "0d929d34052023ed52587ab504c3718602f822940e5c04bafee0e2979ba54ccfb6c924f9d5b21b6f80de295ef3ba1ea6c09da2da6fb482dce2a81c7886fe27a3";
                    };
                };
            );
        };
    };
}
