{ pkgs, libPath, ... }:

let
    hosts = with pkgs; [
        (passff-host.overrideAttrs (old: {
            dontStrip = true;
            patchPhase = ''
                sed -i 's#COMMAND = "pass"#COMMAND = "${pass-wayland.withExtensions (ext: with ext; [pass-otp])}/bin/pass"#' src/passff.py
            '';
        }))
    ];
    mediaWikiSearch = import (libPath + /firefox/search/mediaWiki.nix);
    mkAddon = import (libPath + /firefox/mkAddon.nix);
in {
    programs.firefox = {
        enable = true;
        package = pkgs.firefox.override {
            nativeMessagingHosts = hosts;
        };
        profiles.nixos = {
            extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
                passff
                tampermonkey
                enhancer-for-youtube
                ublock-origin
                duckduckgo-privacy-essentials
                shinigami-eyes
                clearurls
                indie-wiki-buddy
                dearrow
                return-youtube-dislikes
                blocktube
                darkreader
                sponsorblock
            ];
            search = {
                force = true;
                default = "ddg";
                privateDefault = "ddg";
                engines = let
                    updateInterval = 24 * 60 * 60 * 1000; # Every day
                in {
                    bing.metaData.hidden = true;
                    mdn = {
                        name = "MDN Web Docs";
                        urls = [
                            {
                                template = "https://developer.mozilla.org/search";
                                type = "text/html";
                                params = [
                                    { name = "q"; value = "{searchTerms}"; }
                                ];
                            }
                        ];
                        icon = "https://developer.mozilla.org/favicon.ico";
                        inherit updateInterval;
                        description = "Search the MDN Web Docs";
                        definedAliases = [ "@mdn" ];
                    };
                    nixosWiki = mediaWikiSearch {
                        name = "NixOS Wiki";
                        url = "https://wiki.nixos.org";
                        fandomFormat = true;
                        searchURL = "https://wiki.nixos.org/w/index.php";
                        description = "Search on the NixOS Wiki.";
                        inherit updateInterval;
                        definedAliases = [ "@nixoswiki" ];
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
                                    { name = "search_query"; value = "{searchTerms}"; }
                                    { name = "page"; value = "{startPage}"; }
                                ];
                            }
                        ];
                        icon = "https://www.youtube.com/favicon.ico";
                        inherit updateInterval;
                        description = "Search for videos on YouTube";
                        definedAliases = [ "@youtube" "@yt" ];
                    };
                    nixosPackages = {
                        name = "NixOS Packages";
                        urls = [
                            {
                                template = "https://search.nixos.org/packages";
                                type = "text/html";
                                params = [
                                    { name = "channel"; value = "unstable"; }
                                    { name = "query"; value = "{searchTerms}"; }
                                ];
                            }
                        ];
                        icon = "https://search.nixos.org/favicon.png";
                        inherit updateInterval;
                        description = "Search NixOS packages by name or description.";
                        definedAliases = [ "@nixospackages" ];
                    };
                    nixosOptions = {
                        name = "NixOS Options";
                        urls = [
                            {
                                template = "https://search.nixos.org/options";
                                type = "text/html";
                                params = [
                                    { name = "channel"; value = "unstable"; }
                                    { name = "query"; value = "{searchTerms}"; }
                                ];
                            }
                        ];
                        icon = "https://search.nixos.org/favicon.png";
                        inherit updateInterval;
                        description = "Search NixOS options by name or description.";
                        definedAliases = [ "@nixosoptions" ];
                    };
                    modrinthResourcepacks = {
                        name = "Modrinth Resouce Packs";
                        urls = [
                            {
                                template = "https://modrinth.com/resourcepacks";
                                type = "text/html";
                                params = [ { name = "q"; value = "{searchTerms}"; } ];
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
                                params = [ { name = "q"; value = "{searchTerms}"; } ];
                            }
                        ];
                        icon = "https://modrinth.com/favicon.ico";
                        inherit updateInterval;
                        description = "Search for mods on Modrinth, the open source modding platform.";
                        definedAliases = [ "@modrinthmods" "@minecraftmods" ];
                    };
                    protonDB = {
                        name = "ProtonDB";
                        urls = [
                            {
                                template = "https://www.protondb.com/search";
                                type = "text/html";
                                params = [ { name = "q"; value = "{searchTerms}"; } ];
                            }
                        ];
                        icon = "https://www.protondb.com/sites/protondb/images/favicon.ico";
                        inherit updateInterval;
                        description = "Search for Proton compatability for games on Linux.";
                        definedAliases = [ "@protondb" ];
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
                        definedAliases = [ "@subnautica" ];
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
                        definedAliases = [ "@factorio" ];
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
                        definedAliases = [ "@archwiki" ];
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
                        definedAliases = [ "@balatro" ];
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
                        definedAliases = [ "@terraria" ];
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
            };
            bookmarks = {
                force = true;
                settings = [
                    {
                        name = "Nix sites";
                        toolbar = true;
                        bookmarks = [
                            {
                                name = "Home Manager";
                                tags = [
                                    "linux"
                                    "home manager"
                                    "nixos"
                                ];
                                keyword = "homemanager";
                                url = "https://nix-community.github.io/home-manager/options.xhtml";
                            }
                            {
                                name = "Main";
                                tags = [
                                    "tumblr"
                                    "social media"
                                    "blog"
                                    "entertainment"
                                ];
                                keyword = "tumblr";
                                url = "https://www.tumblr.com";
                            }
                            {
                                name = "Bluesky";
                                tags = [
                                    "bluesky"
                                    "social media"
                                    "entertainment"
                                    "blog"
                                ];
                                keyword = "bluesky";
                                url = "https://bsky.app";
                            }
                            {
                                name = "Subscriptions";
                                tags = [
                                    "youtube"
                                    "media"
                                    "entertainment"
                                ];
                                keyword = "youtube";
                                url = "https://www.youtube.com/feed/subscriptions";
                            }
                            {
                                name = "Nebula";
                                tags = [
                                    "nebula"
                                    "media"
                                    "entertainment"
                                ];
                                keyword = "nebula";
                                url = "https://nebula.tv/library";
                            }
                            {
                                name = "LTT";
                                tags = [
                                    "ltt"
                                    "floatplane"
                                    "media"
                                    "entertainment"
                                ];
                                keyword = "floatplane";
                                url = "https://www.floatplane.com/channel/linustechtips/home";
                            }
                            {
                                name = "Dropout";
                                tags = [
                                    "dropout"
                                    "college humor"
                                    "media"
                                    "entertainment"
                                    "improve"
                                    "comedy"
                                ];
                                keyword = "dropout";
                                url = "https://www.dropout.tv/browse";
                            }
                            {
                                name = "Modrinth";
                                tags = [
                                    "modrinth"
                                    "minecraft"
                                    "mods"
                                    "modding"
                                ];
                                keyword = "modrinth";
                                url = "https://modrinth.com/dashboard";
                            }
                            {
                                name = "Ko-fi";
                                tags = [
                                    "ko-fi"
                                    "finance"
                                ];
                                keyword = "kofi";
                                url = "https://ko-fi.com/Manage";
                            }
                            {
                                name = "GitHub";
                                tags = [
                                    "github"
                                    "programming"
                                    "code"
                                    "coding"
                                    "open-source"
                                    "software"
                                ];
                                keyword = "github";
                                url = "https://github.com";
                            }
                            {
                                name = "Bandcamp";
                                tags = [
                                    "music"
                                    "media"
                                    "entertainment"
                                ];
                                keyword = "bandcamp";
                                url = "https://bandcamp.com/thepinkhacker";
                            }
                        ];
                    }
                    {
                        name = "Cohost";
                        tags = [
                            "cohost"
                            "social media"
                            "entertainment"
                        ];
                        keyword = "cohost";
                        url = "https://cohost.org";
                    }
                ];
            };
            settings = {
                "browser.download.panel.shown" = true;
                "browser.aboutConfig.showWarning" = false;
                # Bookmarks
                "browser.bookmarks.restore_default_bookmarks" = false;
                "browser.bookmarks.addedImportButton" = false;
                "browser.toolbars.bookmarks.visibility" = "always";
                # Enable HTTP/3
                "network.http.http3.enabled" = true;
                # Auto play block
                "media.autoplay.default" = false;
                # Allow pasting
                "devtools.selfxss.count" = 5;
                # Disable ads and stuff
                "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
                "browser.urlbar.suggest.quicksuggest.sponsored" = false;
                "browser.contentblocking.category" = "strict";
                "privacy.donottrackheader.enabled" = true;
                "privacy.fingerprintingProtection" = true;
                "privacy.globalprivacycontrol.enabled" = true;
                "identity.fxaccounts.telemetry.clientAssociationPing.enabled" = false;
                "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                "browser.newtabpage.activity-stream.showWeather" = false;
                "browser.newtabpage.activity-stream.feeds.topsites" = false;
                "browser.ml.chat.enabled" = false;
                # Window
                "browser.tabs.inTitlebar" = 0;
                # Theme
                "extensions.activeThemeID" = "firefox-alpenglow@mozilla.org";
                "extensions.autoDisableScopes" = 0;
                # Rendering
                "media.ffmpeg.vaapi.enabled" = true;
                "dom.webgpu.enabled" = true; # Doesn't work yet
                "gfx.webrender.all" = true;
                "image.jxl.enabled" = true;
            };
        };
        policies = {
            AppAutoUpdate = false;
            AutofillAddressEnabled = false;
            AutofillCreditCardEnabled = false;
            BackgroundAppUpdate = false;
            DisableAccounts = true;
            DisableAppUpdate = true;
            DisableFirefoxAccounts = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableSetDesktopBackground = true;
            DisableTelemetry = true;
            DisplayBookmarksToolbar = true;
            DontCheckDefaultBrowser = true;
            EnableTrackingProtection = {
                Value = true;
                Locked = true;
                Cryptomining = true;
                Fingerprinting = true;
                EmailTracking = true;
            };
            EncryptedMediaExtensions = {
                Enabled = true;
                Locked = true;
            };
            FirefoxSuggest = {
                WebSuggestions = false;
                SponsoredSuggestions = false;
                ImproveSuggest = false;
                Locked = true;
            };
            HardwareAcceleration = true;
            HttpsOnlyMode = "force_enabled";
            OfferToSaveLogins = false;
            PasswordManagerEnabled = false;
            PictureInPicture = {
                Enabled = false;
                Locked = true;
            };
            ShowHomeButton = false;
            # about:support
            ExtensionSettings = {
                # X-Kit Rewritten
                "{6e710c58-36cc-49d6-b772-bfc3030fa56e}" = mkAddon {
                    slug = "xkit-rewritten";
                };
                # Nebulizer
                "nebulizer@val.packett.cool" = mkAddon {
                    slug = "nebulizer";
                };
                # Enhancer for Nebula
                "nebula-enhancer@piber.at" = mkAddon {
                    slug = "enhancer-for-nebula";
                };
                # Webrtc Leak Shield
                "@webrtc-leak-shield" = mkAddon {
                    slug = "webrtc-leak-shield";
                };
                # Fandom Enhanced
                "{62818d18-03a3-4ae9-bbe6-d7e7d8b03a0d}" = mkAddon {
                    slug = "fandom-enhance";
                };
                # Chatreplay
                "{25cddbee-458b-4e9f-984d-dbf35511f124}" = mkAddon {
                    slug = "chatreplay";
                };
                # Whenplane Widget
                "{d7efb617-4782-4ca1-841e-f1fde210896b}" = mkAddon {
                    slug = "whenplane-widget";
                };
                # YouTube Live Chat Overlay
                "{c67d2cdf-97be-48a5-b6d1-3f26a7c94294}" = mkAddon {
                    slug = "youtube-live-chat-overlay";
                };
            };
        };
        nativeMessagingHosts = hosts;
    };
}
