{
    inputs,
    config,
    ...
}: let
    pkgs = import inputs.nixpkgs {
        inherit (config.nixpkgs) system;
        overlays = [inputs.nix-minecraft.overlay];
        config.allowUnfree = true;
    };
    inherit (inputs.nix-minecraft.lib) collectFilesAt;
    inherit (pkgs) fetchurl;
in {
    networking.firewall.allowedUDPPorts = [
        # Simple Voice Chat
        24454
    ];

    services.minecraft-servers = {
        enable = true;
        eula = true;
        openFirewall = true;
        servers.optiplex = {
            enable = true;
            autoStart = true;
            package = pkgs.fabricServers.fabric-1_21_10.override {
                loaderVersion = "0.17.3";
            };
            restart = "always";
            #enableReload = true;
            whitelist = {
                BasilissaOfNuts = "9e39a447-6a0b-4fed-87ab-2b6c4dace9c8";
                FormentingStorm = "f7781cd0-2882-43fb-aaec-632e02e8b82f";
                II2E58IE2IE4 = "194339be-156f-4f99-ab78-e2c2804bd5b3";
                LuLuSharkie = "3d01082d-0ddb-4fc8-8d8a-2da05a37ae86";
                Lythoniel = "e27453c2-6130-44c8-899a-cdf7cc27f346";
                mushpiee = "15b8b595-219d-4ba0-ad83-d1fae588b1e0";
                VikingKas = "3e71de4e-6b11-4672-bd47-9f1688bdb52f";
            };
            operators = {
                HazardousSole54 = {
                    uuid = "5f96d607-d822-4eae-8b23-7cfef3799039";
                    bypassesPlayerLimit = true;
                };
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
                #allow-nether = true;
                broadcast-console-to-ops = true;
                broadcast-rcon-to-ops = true;
                bug-report-link = "mailto:/pink@thepinkhacker.com";
                difficulty = "hard";
                enable-code-of-conduct = false;
                #enable-command-block = false;
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
                management-server-enabled = false;
                management-server-host = "localhost";
                management-server-port = 0;
                #management-server-secret = [
                #    "Random text"
                #];
                management-server-tls-enabled = true;
                #management-server-tls-keystore =
                #management-server-tls-keystore-password=
                max-chained-neighbor-updates = 1000000;
                max-players = 20;
                max-tick-time = 60000;
                max-world-size = 29999984;
                motd = "A Server With No Name";
                network-compression-threshold = 256;
                online-mode = true;
                op-permission-level = 4;
                pause-when-empty-seconds = 60;
                player-idle-timeout = 0;
                prevent-proxy-connections = false;
                #pvp = true;
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
                #spawn-monsters = true;
                spawn-protection = 0;
                sync-chunk-writes = true;
                #text-filtering-config = ;
                text-filtering-version = 0;
                use-native-transport = true;
                view-distance = 16;
                white-list = true;
            };
            # nix run github:Infinidoge/nix-minecraft#nix-modrinth-prefetch -- VERSIONID
            symlinks.mods = pkgs.linkFarmFromDrvs "mods" (
                builtins.attrValues {
                    appleskin = fetchurl {
                        url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/8sbiz1lS/appleskin-fabric-mc1.21.9-3.0.7.jar";
                        sha512 = "79d0d0b4a09140cdb7cf74b1cd71554147c60648beb485ca647b149174e171660ec561ad329da58b78b5de439909b180e287b4b38bf068acfca20666100f4584";
                    };
                    audioplayer = fetchurl {
                        url = "https://cdn.modrinth.com/data/SRlzjEBS/versions/YTCMsVNR/audioplayer-fabric-2.0.5%2B1.21.10.jar";
                        sha512 = "fb169f2bc7488d1943efda42600d04ffc9d01c80f9622b7e52375bad93a54e12f1d2f950cc6c444538e0b8b0176528d253c51c1bd6b5c15400ed29d12fee4973";
                    };
                    # For netherportalfix
                    #balm = fetchurl {
                    #    url = "https://cdn.modrinth.com/data/MBAkmtvl/versions/4arCr13S/balm-fabric-1.21.6-21.6.1.jar";
                    #    sha512 = "2ecf65ba78e353f46183223298031a896a5447d1495b74e95e4811907fb636faad018e77af03668522a315d3ee8a52527319fbabaae311e4812f95d4bfb5a273";
                    #};
                    chunky = fetchurl {
                        url = "https://cdn.modrinth.com/data/fALzjamp/versions/kkEljQ4R/Chunky-Fabric-1.4.51.jar";
                        sha512 = "a9bf1e7ce7618acdf202eb93b14bd5f1e50a8fa09c6d2661711a22f8de501c89c7d480c264aa26ef8386c2dab2c88abe467a64e7fb662d3b0865c70e0f72b3e9";
                    };
                    crashexploitfixer = fetchurl {
                        url = "https://cdn.modrinth.com/data/Z5GdSH3X/versions/ibSODuZ1/crashexploitfixer-fabric-1.2.0%2B1.21.5.jar";
                        sha512 = "0a1257b157070d9e4df4104b70e2e04aecfd90666dcab0a6efba9cfa38bc3342172ea1e06f186e7ebfdfa05b867662da1fb780c0dd98f443d3b3b8230d118a17";
                    };
                    decree = pkgs.stdenv.mkDerivation {
                        name = "decree-server-test.jar";
                        buildCommand = "cp ${../assets/decree-server-test.jar} $out";
                    };
                    disconnect-packet-fix = fetchurl {
                        url = "https://cdn.modrinth.com/data/rd9rKuJT/versions/Gv74xveQ/disconnect-packet-fix-fabric-2.0.0.jar";
                        sha512 = "1fd6f09a41ce36284e1a8e9def53f3f6834d7201e69e54e24933be56445ba569fbc26278f28300d36926ba92db6f4f9c0ae245d23576aaa790530345587316db";
                    };
                    enhanced-groups = fetchurl {
                        url = "https://cdn.modrinth.com/data/1LE7mid6/versions/u4ucs3FT/instantgroup-fabric-1.21.10-1.7.0.jar";
                        sha512 = "74b8b46549c471c47d27cb6c500e2bfa36ba171a3741eddae5327212cb4fe612757b7e6aa2be62c92e6899458636c3ce1aca46abf7f691d3ef92d3549ba15c42";
                    };
                    fabric-api = fetchurl {
                        url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/lxeiLRwe/fabric-api-0.136.0%2B1.21.10.jar";
                        sha512 = "d6ad5afeb57dc6dbe17a948990fc8441fbbc13a748814a71566404d919384df8bd7abebda52a58a41eb66370a86b8c4f910b64733b135946ecd47e53271310b5";
                    };
                    ferrite-core = fetchurl {
                        url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar";
                        sha512 = "131b82d1d366f0966435bfcb38c362d604d68ecf30c106d31a6261bfc868ca3a82425bb3faebaa2e5ea17d8eed5c92843810eb2df4790f2f8b1e6c1bdc9b7745";
                    };
                    krypton = fetchurl {
                        url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/O9LmWYR7/krypton-0.2.10.jar";
                        sha512 = "4dcd7228d1890ddfc78c99ff284b45f9cf40aae77ef6359308e26d06fa0d938365255696af4cc12d524c46c4886cdcd19268c165a2bf0a2835202fe857da5cab";
                    };
                    lithium = fetchurl {
                        url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/oGKQMdyZ/lithium-fabric-0.20.0%2Bmc1.21.10.jar";
                        sha512 = "755c0e0fc7f6f38ac4d936cc6023d1dce6ecfd8d6bdc2c544c2a3c3d6d04f0d85db53722a089fa8be72ae32fc127e87f5946793ba6e8b4f2c2962ed30d333ed2";
                    };
                    #netherportalfix = fetchurl {
                    #    url = "https://cdn.modrinth.com/data/nPZr02ET/versions/P3NCOkYd/netherportalfix-fabric-1.21.6-21.6.1.jar";
                    #    sha512 = "ce9cc3dec9c01725a2c28ea275ef9e96b3ce7822a63de4b6e9c9eb36fda4ebee4c8be233de9dbb214b7e1302801702b6c59efbf834be006debc5c205831b35e3";
                    #};
                    scalablelux = fetchurl {
                        url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/PV9KcrYQ/ScalableLux-0.1.6%2Bfabric.c25518a-all.jar";
                        sha512 = "729515c1e75cf8d9cd704f12b3487ddb9664cf9928e7b85b12289c8fbbc7ed82d0211e1851375cbd5b385820b4fedbc3f617038fff5e30b302047b0937042ae7";
                    };
                    shulkerboxtooltip = fetchurl {
                        url = "https://cdn.modrinth.com/data/2M01OLQq/versions/4DMOp59l/shulkerboxtooltip-fabric-5.2.11%2B1.21.9.jar";
                        sha512 = "d251b3cc7b4871582ac384c491d2c17d73b8852061c4ced900a777fae0f6200f0711fad105575abd79b82e397cb92aea31e29d422c68a63cf33384567db8f083";
                    };
                    shulker-box-label = fetchurl {
                        url = "https://cdn.modrinth.com/data/a4byiEVJ/versions/nd6korVE/shulker-box-labels-3.4.0%2B1.21.9-fabric.jar";
                        sha512 = "ddd8e81b9a788bc800bb6170b64c288e112fc8921979072a4eb784c613bbc89ecf1177dabf4f39e08dc5fd2acb04486307749f6e6a293f786714467357c4f312";
                    };
                    slime = fetchurl {
                        url = "https://cdn.modrinth.com/data/qpnMRvwM/versions/JCze8FLM/Slime-1.21.10.jar";
                        sha512 = "f75946d4e3e452d8be404857fc53dcbe7adac9344e59424de3bf4126c1f65ce2ec28496141d243407e9105209f3c49bcc2403438328170762010b5a354d6d1e8";
                    };
                    voicechat = fetchurl {
                        url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/BjR2lc4k/voicechat-fabric-1.21.10-2.6.6.jar";
                        sha512 = "fc0b838a0906ddafeabf9db3b459d4226a2f06458443ee1dee44d937e5896f0d8d3e7c7bbc2a93ea74b4665f37249e7da719bbabf8449c756d2a49116be61197";
                    };
                }
            );
        };
    };
}
