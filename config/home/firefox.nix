{ pkgs, inputs, system, ... }:

{
    programs.firefox = {
        enable = true;
        profiles.default = {
            path = "default";
        };
        profiles.nixos = {
            id = 1;
            extensions = with inputs.firefox-addons.packages.${system}; [
                #tampermonkey
                #enhancer-for-youtube
                ublock-origin
                duckduckgo-privacy-essentials
                shinigami-eyes
                plasma-integration
                clearurls
                indie-wiki-buddy
                #xkit
                #nebulizer
                #enhancer-for-nebula
                dearrow
                #webrtc-leak-shield
                return-youtube-dislikes
                blocktube
                #fandom-enhanced
                #chatreplay
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
                        description = "Search for videos on YouTube";
                        definedAliases = [ "@youtube" "@yt" ];
                    };
                };
            };
            bookmarks = [
                {
                    name = "Main";
                    tags = [
                        "tumblr"
                        "social media"
                    ];
                    keyword = "tumblr";
                    url = "https://www.tumblr.com/";
                }
            ];
            settings = {
                "dom.security.https_only_mode" = true;
                "browser.download.panel.shown" = true;
                "identity.fxaccounts.enabled" = false;
                "signon.rememberSignons" = false;
                "browser.aboutConfig.showWarning" = false;
                # Enable HTTP/3
                "network.http.http3.enabled" = true;
                # Auto play block
                "media.autoplay.default" = false;
                "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
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
            };
        };
        nativeMessagingHosts = with pkgs; [ passff-host ];
    };
}
