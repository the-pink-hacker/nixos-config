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
            package = pkgs.fabricServers.fabric-1_21_7.override {
                loaderVersion = "0.16.14";
            };
            restart = "always";
            #enableReload = true;
            whitelist = {
                BasilissaOfNuts = "9e39a447-6a0b-4fed-87ab-2b6c4dace9c8";
                FormentingStorm = "f7781cd0-2882-43fb-aaec-632e02e8b82f";
                II2E58IE2IE4 = "194339be-156f-4f99-ab78-e2c2804bd5b3";
                LuLuSharkie = "3d01082d-0ddb-4fc8-8d8a-2da05a37ae86";
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
                motd = "A Server With No Name";
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
            # nix run github:Infinidoge/nix-minecraft#nix-modrinth-prefetch -- VERSIONID
            symlinks.mods = pkgs.linkFarmFromDrvs "mods" (
                builtins.attrValues {
                    appleskin = fetchurl {
                        url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/YAjCkZ29/appleskin-fabric-mc1.21.6-3.0.6.jar";
                        sha512 = "e36c78b036676b3fac1ec3edefdcf014ccde8ce65fd3e9c1c2f9a7bbc7c94185168a2cd6c8c27564e9204cd892bfbaae9989830d1acea83e6f37187b7a43ad7d";
                    };
                    audioplayer = fetchurl {
                        url = "https://cdn.modrinth.com/data/SRlzjEBS/versions/1cNRNynB/audioplayer-fabric-1.21.7-1.13.2.jar";
                        sha512 = "555ad4b922883fad02b3c34d7151512169dd0c8bf2a3e119b452bb5b403447df2b11dd8de90956afdbc0ca611c900c5f81b54bff03a1a02c1a71b403609d270b";
                    };
                    # For netherportalfix
                    #balm = fetchurl {
                    #    url = "https://cdn.modrinth.com/data/MBAkmtvl/versions/4arCr13S/balm-fabric-1.21.6-21.6.1.jar";
                    #    sha512 = "2ecf65ba78e353f46183223298031a896a5447d1495b74e95e4811907fb636faad018e77af03668522a315d3ee8a52527319fbabaae311e4812f95d4bfb5a273";
                    #};
                    chunky = fetchurl {
                        url = "https://cdn.modrinth.com/data/fALzjamp/versions/inWDi2cf/Chunky-Fabric-1.4.40.jar";
                        sha512 = "9e0386d032641a124fd953a688a48066df7f4ec1186f7f0f8b0a56d49dced220e2d6938ed56e9d8ead78bb80ddb941bc7873f583add8e565bdacdf62e13adc28";
                    };
                    crashexploitfixer = fetchurl {
                        url = "https://cdn.modrinth.com/data/Z5GdSH3X/versions/ibSODuZ1/crashexploitfixer-fabric-1.2.0%2B1.21.5.jar";
                        sha512 = "0a1257b157070d9e4df4104b70e2e04aecfd90666dcab0a6efba9cfa38bc3342172ea1e06f186e7ebfdfa05b867662da1fb780c0dd98f443d3b3b8230d118a17";
                    };
                    decree = fetchurl {
                        url = "https://github.com/the-pink-hacker/nixos-config/raw/38b4d3e982816b9116a2133f4d5bdc29798f2380/assets/decree-server-test.jar";
                        sha256 = "sha256-GjkdZGsJXm7dmlV21/QlR+vEjCjZg7w+EOtfv6SR21k=";
                    };
                    disconnect-packet-fix = fetchurl {
                        url = "https://cdn.modrinth.com/data/rd9rKuJT/versions/Gv74xveQ/disconnect-packet-fix-fabric-2.0.0.jar";
                        sha512 = "1fd6f09a41ce36284e1a8e9def53f3f6834d7201e69e54e24933be56445ba569fbc26278f28300d36926ba92db6f4f9c0ae245d23576aaa790530345587316db";
                    };
                    enhanced-groups = fetchurl {
                        url = "https://cdn.modrinth.com/data/1LE7mid6/versions/SuYYBTU7/instantgroup-fabric-1.21.7-1.7.0.jar";
                        sha512 = "f30896a000ce0725667c8e47f0788703b8c08d89fed8fe9e590f231f9e57dd590c799e51095586e5fc5ce3f45e9bbbab5f9bdc8af4d63a8826cfbda0569ae923";
                    };
                    fabric-api = fetchurl {
                        url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/JIZogEYa/fabric-api-0.128.2%2B1.21.7.jar";
                        sha512 = "afb9b3d1040689f53dd51341626b04d197e7d057d578a72c7a374a66465e0e07f5b3d52721d71e36be26d197668d3a96ea50dbb85e2bc5835d9d858e31b15966";
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
                        url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/77EtzYFA/lithium-fabric-0.18.0%2Bmc1.21.7.jar";
                        sha512 = "afaf6ddaf0cbae2050d725efd438c4c98141d738a637f0f058dcbaff077ef85af801e2dca138ce9f7f8ba3a169dc6af1c9f56736b255c6ea13363f8a1be8ecdb";
                    };
                    #netherportalfix = fetchurl {
                    #    url = "https://cdn.modrinth.com/data/nPZr02ET/versions/P3NCOkYd/netherportalfix-fabric-1.21.6-21.6.1.jar";
                    #    sha512 = "ce9cc3dec9c01725a2c28ea275ef9e96b3ce7822a63de4b6e9c9eb36fda4ebee4c8be233de9dbb214b7e1302801702b6c59efbf834be006debc5c205831b35e3";
                    #};
                    scalablelux = fetchurl {
                        url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/PQLHDg2Q/ScalableLux-0.1.5%2Bfabric.e4acdcb-all.jar";
                        sha512 = "ec8fabc3bf991fbcbe064c1e97ded3e70f145a87e436056241cbb1e14c57ea9f59ef312f24c205160ccbda43f693e05d652b7f19aa71f730caec3bb5f7f7820a";
                    };
                    shulkerboxtooltip = fetchurl {
                        url = "https://cdn.modrinth.com/data/2M01OLQq/versions/os3K6gc6/shulkerboxtooltip-fabric-5.2.8%2B1.21.7.jar";
                        sha512 = "ab99874d017e71bce2019cf5e8f5e0b8584ee0a00f4beb8212b368686bab6b4cf5cc242e2a8c4905c75c3a421b8035234b7e9abcc325dc702af518229b819646";
                    };
                    shulker-box-label = fetchurl {
                        url = "https://cdn.modrinth.com/data/a4byiEVJ/versions/BMET9tpv/shulker-box-labels-3.2.0%2B1.21.7.jar";
                        sha512 = "0747355d57b9627adcf6065c8a76a4578c8c67cbbb9a630d9e91212b86f1a8b90318def3f587a4aafcf47311c15a26edae844ac428f9d77b0918adc5f49b101c";
                    };
                    # 1.21.6
                    #slime = fetchurl {
                    #    url = "https://cdn.modrinth.com/data/qpnMRvwM/versions/bDOWNLz2/Slime-1.21.6.jar";
                    #    sha512 = "0d929d34052023ed52587ab504c3718602f822940e5c04bafee0e2979ba54ccfb6c924f9d5b21b6f80de295ef3ba1ea6c09da2da6fb482dce2a81c7886fe27a3";
                    #};
                    voicechat = fetchurl {
                        url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/bilPCGtM/voicechat-fabric-1.21.7-2.5.33.jar";
                        sha512 = "03f76e24b00dfad1fb4cb4a58f4c200da5ae1d62437e162e88fe9bef9024a3e8cff94787f15f20a4dbf85c8f53a45feac8a7bbeb7a5686017d027cfa6c4a593e";
                    };
                }
            );
        };
    };
}
