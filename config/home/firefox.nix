{ pkgs, ... }:

let
    hosts = with pkgs; [
        (passff-host.overrideAttrs (old: {
            dontStrip = true;
            patchPhase = ''
                sed -i 's#COMMAND = "pass"#COMMAND = "${pass.withExtensions (ext: with ext; [pass-otp])}/bin/pass"#' src/passff.py
            '';
        }))
    ];
in {
    programs.firefox = {
        enable = true;
        package = pkgs.firefox.override {
            nativeMessagingHosts = hosts;
        };
        profiles.nixos = {
            extensions = with pkgs.nur.repos.rycee.firefox-addons; [
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
                default = "DuckDuckGo";
                privateDefault = "DuckDuckGo";
                engines = let
                    updateInterval = 24 * 60 * 60 * 1000; # Every day
                in {
                    Bing.metaData.hidden = true;
                    "MDN Web Docs" = {
                        urls = [
                            {
                                template = "https://developer.mozilla.org/search";
                                type = "text/html";
                                params = [
                                    { name = "q"; value = "{searchTerms}"; }
                                ];
                            }
                        ];
                        iconUpdateURL = "https://developer.mozilla.org/favicon.ico";
                        inherit updateInterval;
                        description = "Search the MDN Web Docs";
                        definedAliases = [ "@mdn" ];
                    };
                    "NixOS Wiki" = {
                        urls = [
                            {
                                template = "https://wiki.nixos.org/w/index.php";
                                type = "text/html";
                                params = [
                                    { name = "search"; value = "{searchTerms}"; }
                                ];
                            }
                        ];
                        iconUpdateURL = "https://wiki.nixos.org/favicon.ico";
                        inherit updateInterval;
                        definedAliases = [ "@nixoswiki" ];
                    };
                    "Minecraft Wiki (EN)" = {
                        urls = [
                            {
                                template = "https://minecraft.wiki/w/Special:Search";
                                type = "text/html";
                                params = [
                                    { name = "search"; value = "{searchTerms}"; }
                                ];
                            }
                            {
                                template = "https://minecraft.wiki/api.php";
                                type = "application/x-suggestions+json";
                                params = [
                                    { name = "action"; value = "opensearch"; }
                                    { name = "search"; value = "{searchTerms}"; }
                                    { name = "namespace"; value = "0|10000|10002|10004|10006"; }
                                    { name = "maxage"; value = "600"; }
                                    { name = "uselang"; value = "content"; }
                                ];
                            }
                        ];
                        iconUpdateURL = "https://minecraft.wiki/favicon.ico";
                        inherit updateInterval;
                        definedAliases = [ "@minecraft" "@mc" ];
                    };
                    "YouTube" = {
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
                        iconUpdateURL = "https://www.youtube.com/favicon.ico";
                        inherit updateInterval;
                        description = "Search for videos on YouTube";
                        definedAliases = [ "@youtube" "@yt" ];
                    };
                    "NixOS Packages" = {
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
                        iconUpdateURL = "https://search.nixos.org/favicon.png";
                        inherit updateInterval;
                        description = "Search NixOS packages by name or description.";
                        definedAliases = [ "@nixospackages" ];
                    };
                    "NixOS Options" = {
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
                        iconUpdateURL = "https://search.nixos.org/favicon.png";
                        inherit updateInterval;
                        description = "Search NixOS options by name or description.";
                        definedAliases = [ "@nixosoptions" ];
                    };
                    "Modrinth Resouce Packs" = {
                        urls = [
                            {
                                template = "https://modrinth.com/resourcepacks";
                                type = "text/html";
                                params = [ { name = "q"; value = "{searchTerms}"; } ];
                            }
                        ];
                        iconUpdateURL = "https://modrinth.com/favicon.ico";
                        inherit updateInterval;
                        description = "Search for resource packs on Modrinth, the open source modding platform.";
                        definedAliases = [
                            "@modrinthresourcepacks"
                            "@resourcepacks"
                            "@minecraftresourcepacks"
                        ];
                    };
                    "Modrinth Mods" = {
                        urls = [
                            {
                                template = "https://modrinth.com/mods";
                                type = "text/html";
                                params = [ { name = "q"; value = "{searchTerms}"; } ];
                            }
                        ];
                        iconUpdateURL = "https://modrinth.com/favicon.ico";
                        inherit updateInterval;
                        description = "Search for mods on Modrinth, the open source modding platform.";
                        definedAliases = [ "@modrinthmods" "@minecraftmods" ];
                    };
                    "ProtonDB" = {
                        urls = [
                            {
                                template = "https://www.protondb.com/search";
                                type = "text/html";
                                params = [ { name = "q"; value = "{searchTerms}"; } ];
                            }
                        ];
                        iconUpdateURL = "https://www.protondb.com/sites/protondb/images/favicon.ico";
                        inherit updateInterval;
                        description = "Search for Proton compatability for games on Linux.";
                        definedAliases = [ "@protondb" ];
                    };
                    "Subnautica Wiki" = {
                        urls = [
                            {
                                template = "https://subnautica.fandom.com/wiki/Special:Search";
                                type = "text/html";
                                params = [{
                                    name = "search";
                                    value = "{searchTerms}";
                                }];
                            }
                            {
                                template = "https://subnautica.fandom.com/api.php";
                                type = "application/x-suggestions+json";
                                params = [
                                    {
                                        name = "action";
                                        value = "opensearch";
                                    }
                                    {
                                        name = "search";
                                        value = "{searchTerms}";
                                    }
                                    {
                                        name = "namespace";
                                        value = "0|2900";
                                    }
                                ];
                            }
                        ];
                        iconUpdateURL = "https://subnautica.fandom.com/favicon.ico";
                        inherit updateInterval;
                        description = "Search on the Subnautica wiki.";
                        definedAliases = [ "@subnautica" ];
                    };
                    "Factorio Wiki" = {
                        urls = [
                            {
                                template = "https://wiki.factorio.com/Special:Search";
                                type = "text/html";
                                params = [{
                                    name = "search";
                                    value = "{searchTerms}";
                                }];
                            }
                            {
                                template = "https://wiki.factorio.com/api.php";
                                type = "application/x-suggestions+json";
                                params = [
                                    {
                                        name = "action";
                                        value = "opensearch";
                                    }
                                    {
                                        name = "search";
                                        value = "{searchTerms}";
                                    }
                                    {
                                        name = "namespace";
                                        value = "0|3000|102|108";
                                    }
                                ];
                            }
                        ];
                        iconUpdateURL = "https://wiki.factorio.com/favicon.ico";
                        inherit updateInterval;
                        description = "Search on the Factorio wiki.";
                        definedAliases = [ "@factorio" ];
                    };
                };
            };
            bookmarks = [
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
                            name = "Cohost";
                            tags = [
                                "cohost"
                                "social media"
                                "entertainment"
                            ];
                            keyword = "cohost";
                            url = "https://cohost.org";
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
                                "media"
                                "floatplane"
                                "media"
                                "entertainment"
                            ];
                            keyword = "floatplane";
                            url = "https://www.floatplane.com/channel/linustechtips/home";
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
                    ];
                }
            ];
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
                "{6e710c58-36cc-49d6-b772-bfc3030fa56e}" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/xkit-rewritten/latest.xpi";
                    installation_mode = "force_installed";
                };
                # Nebulizer
                "nebulizer@val.packett.cool" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/nebulizer/latest.xpi";
                    installation_mode = "force_installed";
                };
                # Enhancer for Nebula
                "nebula-enhancer@piber.at" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/enhancer-for-nebula/latest.xpi";
                    installation_mode = "force_installed";
                };
                # Webrtc Leak Shield
                "@webrtc-leak-shield" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/webrtc-leak-shield/latest.xpi";
                    installation_mode = "force_installed";
                };
                # Fandom Enhanced
                "{62818d18-03a3-4ae9-bbe6-d7e7d8b03a0d}" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/fandom-enhance/latest.xpi";
                    installation_mode = "force_installed";
                };
                # Chatreplay
                "{25cddbee-458b-4e9f-984d-dbf35511f124}" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/chatreplay/latest.xpi";
                    installation_mode = "force_installed";
                };
                # Whenplane Widget
                "{d7efb617-4782-4ca1-841e-f1fde210896b}" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/whenplane-widget/latest.xpi";
                    installation_mode = "force_installed";
                };
            };
        };
        nativeMessagingHosts = hosts;
    };
}
