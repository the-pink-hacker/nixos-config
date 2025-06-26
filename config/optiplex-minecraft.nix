{ inputs, config, ... }:

let 
    pkgs = import inputs.nixpkgs {
        inherit (config.nixpkgs) system;
        overlays = [ inputs.nix-minecraft.overlay ];
        config.allowUnfree = true;
    };
    inherit (inputs.nix-minecraft.lib) collectFilesAt;
    inherit (pkgs) fetchurl;
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
                HazardousSole54 = "5f96d607-d822-4eae-8b23-7cfef3799039";
                II2E58IE2IE4 = "194339be-156f-4f99-ab78-e2c2804bd5b3";
                mushpiee = "15b8b595-219d-4ba0-ad83-d1fae588b1e0";
            };
            operators = {
                ThePinkHacker = {
                    uuid = "a0893fac-b70f-45ca-8901-eea269c6b444";
                    bypassesPlayerLimit = true;
                };
            };
            jvmOpts = [
                "-Xms2G"
                "-Xmx10G"
            ];
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
                #initial-disabled-packs = "";
                initial-enabled-packs = builtins.concatStringsSep "," [
                    "vanilla"
                    "minecraft:minecart_improvements"
                ];
                level-name = "minecraft-optiplex";
                # wikicamp2electricboogaloo
                level-seed = "-13543954";
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
                spawn-protection = 0;
                sync-chunk-writes = true;
                #text-filtering-config = ;
                text-filtering-version = 0;
                use-native-transport = true;
                view-distance = 16;
                white-list = true;
            };
            symlinks.mods = pkgs.linkFarmFromDrvs "mods" (
                builtins.attrValues {
                    appleskin = fetchurl {
                        url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/P8sTsYtJ/appleskin-neoforge-mc1.21.5-3.0.7.jar";
                        sha512 = "96981518f34022af38df02e7b34c5a918af89723b965c578c73cb34a886f8c27606bafcf4e88db602575ca9cd1d4f9a93aa2870fbefccd73fd64d829323b955a";
                    };
                    # For netherportalfix
                    balm = fetchurl {
                        url = "https://cdn.modrinth.com/data/MBAkmtvl/versions/4arCr13S/balm-fabric-1.21.6-21.6.1.jar";
                        sha512 = "2ecf65ba78e353f46183223298031a896a5447d1495b74e95e4811907fb636faad018e77af03668522a315d3ee8a52527319fbabaae311e4812f95d4bfb5a273";
                    };
                    chunky = fetchurl {
                        url = "https://cdn.modrinth.com/data/fALzjamp/versions/inWDi2cf/Chunky-Fabric-1.4.40.jar";
                        sha512 = "9e0386d032641a124fd953a688a48066df7f4ec1186f7f0f8b0a56d49dced220e2d6938ed56e9d8ead78bb80ddb941bc7873f583add8e565bdacdf62e13adc28";
                    };
                    crashexploitfixer = fetchurl {
                        url = "https://cdn.modrinth.com/data/Z5GdSH3X/versions/ibSODuZ1/crashexploitfixer-fabric-1.2.0%2B1.21.5.jar";
                        sha512 = "0a1257b157070d9e4df4104b70e2e04aecfd90666dcab0a6efba9cfa38bc3342172ea1e06f186e7ebfdfa05b867662da1fb780c0dd98f443d3b3b8230d118a17";
                    };
                    fabric-api = fetchurl {
                        url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/N3z6cNQv/fabric-api-0.127.1%2B1.21.6.jar";
                        sha512 = "c7b4ea754a486193476b33ac4d1eaeb30b644e05b76a6abe8cf51ca4eb6832063d32293f1c9052c32c806712d26f85b531085a3ff52575021ee831a804167c4d";
                    };
                    ferrite-core = fetchurl {
                        url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar";
                        sha512 = "131b82d1d366f0966435bfcb38c362d604d68ecf30c106d31a6261bfc868ca3a82425bb3faebaa2e5ea17d8eed5c92843810eb2df4790f2f8b1e6c1bdc9b7745";
                    };
                    krypton = fetchurl {
                        url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/neW85eWt/krypton-0.2.9.jar";
                        sha512 = "2e2304b1b17ecf95783aee92e26e54c9bfad325c7dfcd14deebf9891266eb2933db00ff77885caa083faa96f09c551eb56f93cf73b357789cb31edad4939ffeb";
                    };
                    lithium = fetchurl {
                        url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/XWGBHYcB/lithium-fabric-0.17.0%2Bmc1.21.6.jar";
                        sha512 = "a8d6a8b69ae2b10dd0cf8f8149260d5bdbd2583147462bad03380014edd857852972b967d97df69728333d8836b1e9db8997712ea26365ddb8a05b8c845c6534";
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
                    voicechat = fetchurl {
                        url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/pG8PLA08/voicechat-fabric-1.21.6-2.5.30.jar";
                        sha512 = "917ea307782b0fb141aa35efa2462e0c148bd3ff3aeec978ba49d0b593374cb20dd2ad5d021c6c11a9e8262056d7553df025593d79b27a33e5e7bec816ab6756";
                    };
                }
            );
        };
    };
}
