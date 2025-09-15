{...}: {
    programs.firefox.profiles.nixos.bookmarks.force = true;
    programs.firefox.profiles.nixos.bookmarks.settings = [
        {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
                {
                    name = "Ivy Learn";
                    tags = [
                        "ivy"
                        "ivytech"
                        "ivy tech"
                        "canvas"
                    ];
                    keyword = "ivylearn";
                    url = "https://ivylearn.ivytech.edu";
                }
                {
                    name = "MyIvy";
                    tags = [
                        "ivy"
                        "ivytech"
                        "ivy tech"
                    ];
                    keyword = "myivy";
                    url = "https://my.ivytech.edu/myivy";
                }
                {
                    name = "Mail";
                    tags = [
                        "email"
                        "mail"
                        "proton"
                    ];
                    keyword = "email";
                    url = "https://mail.proton.me/u/0/inbox";
                }
                {
                    name = "Calendar";
                    tags = [
                        "calendar"
                        "proton"
                    ];
                    keyword = "calendar";
                    url = "https://calendar.proton.me/u/0/";
                }
                {
                    name = "Drive";
                    tags = [
                        "drive"
                        "proton"
                    ];
                    keyword = "drive";
                    url = "https://drive.proton.me/u/0/";
                }
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
                    name = "Wafrn";
                    tags = [
                        "bluesky"
                        "mastodon"
                        "wafrn"
                        "social media"
                        "entertainment"
                        "blog"
                    ];
                    keyword = "wafrn";
                    url = "https://app.wafrn.net/dashboard";
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
        {
            name = "Minecraft Enchantment Calculator";
            tags = [
                "minecraft"
                "tool"
            ];
            keyword = "minecraft-enchantments";
            url = "https://iamcal.github.io/enchant-order/";
        }
    ];
}
