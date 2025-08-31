{
    pkgs,
    libPath,
    ...
}: let
    hosts = with pkgs; [
        (passff-host.overrideAttrs (old: {
            dontStrip = true;
            patchPhase = ''
                sed -i 's#COMMAND = "pass"#COMMAND = "${pass-wayland.withExtensions (ext: with ext; [pass-otp])}/bin/pass"#' src/passff.py
            '';
        }))
    ];
    mkAddon = import (libPath + /firefox/mkAddon.nix);
in {
    imports = map (path: ./firefox + path) [
        /bookmarks.nix
        /engines.nix
    ];

    programs.firefox = {
        enable = true;
        package = pkgs.firefox.override {
            nativeMessagingHosts = hosts;
        };
        profiles.nixos = {
            extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
                passff
                tampermonkey
                #enhancer-for-youtube
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
                # Enhancer for Youtube
                "enhancerforyoutube@maximerf.addons.mozilla.org" = {
                    install_url = "https://www.mrfdev.com/downloads/enhancer_for_youtube-2.0.130.1.xpi";
                    installation_mode = "force_installed";
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
