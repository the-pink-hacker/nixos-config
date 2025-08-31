{libPath, ...}: let
    mediaWikiSearch = import (libPath + /firefox/search/mediaWiki.nix);
    updateInterval = 24 * 60 * 60 * 1000; # Every day
in {
    programs.firefox.profiles.nixos.search.engines = {
        bing.metaData.hidden = true;
        mdn = {
            name = "MDN Web Docs";
            urls = [
                {
                    template = "https://developer.mozilla.org/search";
                    type = "text/html";
                    params = [
                        {
                            name = "q";
                            value = "{searchTerms}";
                        }
                    ];
                }
            ];
            icon = "https://developer.mozilla.org/favicon.ico";
            inherit updateInterval;
            description = "Search the MDN Web Docs";
            definedAliases = ["@mdn"];
        };
        nixosWiki = mediaWikiSearch {
            name = "NixOS Wiki";
            url = "https://wiki.nixos.org";
            fandomFormat = true;
            searchURL = "https://wiki.nixos.org/w/index.php";
            description = "Search on the NixOS Wiki.";
            inherit updateInterval;
            definedAliases = ["@nixoswiki"];
        };
        minecraftWiki = mediaWikiSearch {
            name = "Minecraft Wiki (EN)";
            url = "https://minecraft.wiki";
            fandomFormat = true;
            searchURL = "https://minecraft.wiki/w/Special:Search";
            additionalSuggestionParams = [
                {
                    name = "maxage";
                    value = "600";
                }
                {
                    name = "uselang";
                    value = "content";
                }
            ];
            inherit updateInterval;
            description = "Search on the Minecraft Wiki.";
            definedAliases = [
                "@minecraft"
                "@mc"
            ];
        };
        youtube = {
            name = "YouTube";
            urls = [
                {
                    template = "https://www.youtube.com/results";
                    type = "text/html";
                    params = [
                        {
                            name = "search_query";
                            value = "{searchTerms}";
                        }
                        {
                            name = "page";
                            value = "{startPage}";
                        }
                    ];
                }
            ];
            icon = "https://www.youtube.com/favicon.ico";
            inherit updateInterval;
            description = "Search for videos on YouTube";
            definedAliases = ["@youtube" "@yt"];
        };
        nixosPackages = {
            name = "NixOS Packages";
            urls = [
                {
                    template = "https://search.nixos.org/packages";
                    type = "text/html";
                    params = [
                        {
                            name = "channel";
                            value = "unstable";
                        }
                        {
                            name = "query";
                            value = "{searchTerms}";
                        }
                    ];
                }
            ];
            icon = "https://search.nixos.org/favicon.png";
            inherit updateInterval;
            description = "Search NixOS packages by name or description.";
            definedAliases = ["@nixospackages"];
        };
        nixosOptions = {
            name = "NixOS Options";
            urls = [
                {
                    template = "https://search.nixos.org/options";
                    type = "text/html";
                    params = [
                        {
                            name = "channel";
                            value = "unstable";
                        }
                        {
                            name = "query";
                            value = "{searchTerms}";
                        }
                    ];
                }
            ];
            icon = "https://search.nixos.org/favicon.png";
            inherit updateInterval;
            description = "Search NixOS options by name or description.";
            definedAliases = ["@nixosoptions"];
        };
        modrinthResourcepacks = {
            name = "Modrinth Resouce Packs";
            urls = [
                {
                    template = "https://modrinth.com/resourcepacks";
                    type = "text/html";
                    params = [
                        {
                            name = "q";
                            value = "{searchTerms}";
                        }
                    ];
                }
            ];
            icon = "https://modrinth.com/favicon.ico";
            inherit updateInterval;
            description = "Search for resource packs on Modrinth, the open source modding platform.";
            definedAliases = [
                "@modrinthresourcepacks"
                "@resourcepacks"
                "@minecraftresourcepacks"
            ];
        };
        modrinthMods = {
            name = "Modrinth Mods";
            urls = [
                {
                    template = "https://modrinth.com/mods";
                    type = "text/html";
                    params = [
                        {
                            name = "q";
                            value = "{searchTerms}";
                        }
                    ];
                }
            ];
            icon = "https://modrinth.com/favicon.ico";
            inherit updateInterval;
            description = "Search for mods on Modrinth, the open source modding platform.";
            definedAliases = ["@modrinthmods" "@minecraftmods"];
        };
        protonDB = {
            name = "ProtonDB";
            urls = [
                {
                    template = "https://www.protondb.com/search";
                    type = "text/html";
                    params = [
                        {
                            name = "q";
                            value = "{searchTerms}";
                        }
                    ];
                }
            ];
            icon = "https://www.protondb.com/sites/protondb/images/favicon.ico";
            inherit updateInterval;
            description = "Search for Proton compatability for games on Linux.";
            definedAliases = ["@protondb"];
        };
        subnauticaWiki = mediaWikiSearch {
            name = "Subnautica Wiki";
            url = "https://subnautica.fandom.com";
            fandomFormat = true;
            suggestionNamespaces = [
                0
                2900
            ];
            inherit updateInterval;
            description = "Search on the Subnautica wiki.";
            definedAliases = ["@subnautica"];
        };
        factorioWiki = mediaWikiSearch {
            name = "Factorio Wiki";
            url = "https://wiki.factorio.com";
            suggestionNamespaces = [
                0
                3000
                102
                108
            ];
            inherit updateInterval;
            description = "Search on the Factorio wiki.";
            definedAliases = ["@factorio"];
        };
        archWiki = mediaWikiSearch {
            name = "Arch Linux Wiki";
            url = "https://wiki.archlinux.org";
            suggestionNamespaces = [
                0
                3000
            ];
            inherit updateInterval;
            description = "Search on the Arch Linux Wiki.";
            definedAliases = ["@archwiki"];
        };
        bandcamp = {
            name = "bandcamp";
            urls = [
                {
                    template = "https://bandcamp.com/search";
                    type = "text/html";
                    params = [
                        {
                            name = "q";
                            value = "{searchTerms}";
                        }
                    ];
                }
            ];
            icon = "https://s4.bcbits.com/img/favicon/favicon-32x32.png";
            inherit updateInterval;
            description = "Search for music, albums, and artists on Bandcamp.";
            definedAliases = [
                "@bandcamp"
            ];
        };
        github = {
            name = "GitHub";
            urls = [
                {
                    template = "https://github.com/search";
                    type = "text/html";
                    params = [
                        {
                            name = "q";
                            value = "{searchTerms}";
                        }
                        {
                            name = "ref";
                            value = "opensearch";
                        }
                    ];
                }
            ];
            icon = "https://github.com/favicon.ico";
            inherit updateInterval;
            description = "Search GitHub";
            definedAliases = [
                "@github"
            ];
        };
        balatroWiki = mediaWikiSearch {
            name = "Balatro Wiki (en)";
            url = "https://balatrogame.fandom.com";
            fandomFormat = true;
            suggestionNamespaces = [
                0
                2900
            ];
            inherit updateInterval;
            description = "Search on the Balatro wiki.";
            definedAliases = ["@balatro"];
        };
        terrariaWiki = mediaWikiSearch {
            name = "Terraria Wiki (en)";
            url = "https://terraria.wiki.gg";
            fandomFormat = true;
            suggestionNamespaces = [
                0
            ];
            additionalSuggestionParams = [
                {
                    name = "maxage";
                    value = "10800";
                }
                {
                    name = "smaxage";
                    value = "10800";
                }
                {
                    name = "uselang";
                    value = "content";
                }
            ];
            inherit updateInterval;
            description = "Search on the Terraria wiki.";
            definedAliases = ["@terraria"];
        };
        riskOfRain2Wiki = mediaWikiSearch {
            name = "Risk of Rain 2 Wiki (en)";
            url = "https://riskofrain2.wiki.gg";
            fandomFormat = true;
            suggestionNamespaces = [
                0
            ];
            additionalSuggestionParams = [
                {
                    name = "maxage";
                    value = "10800";
                }
                {
                    name = "smaxage";
                    value = "10800";
                }
                {
                    name = "uselang";
                    value = "content";
                }
            ];
            inherit updateInterval;
            description = "Search on the Risk of Rain 2 wiki.";
            definedAliases = [
                "@riskofrain2"
                "@riskofrain"
            ];
        };
        wikiCamp2 = mediaWikiSearch {
            name = "Wiki Camp 2";
            url = "https://camp2.rectangle.zone";
            fandomFormat = true;
            suggestionNamespaces = [
                0
            ];
            inherit updateInterval;
            description = "Search on the Wiki Camp 2.";
            definedAliases = [
                "@camp2"
            ];
        };
    };
}
