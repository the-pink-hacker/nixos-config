{syncthingEnable, ...}: {
    services.syncthing = {
        enable = syncthingEnable;
        user = "pink";
        group = "users";
        dataDir = "/home/pink/.local/state/syncthing";
        overrideFolders = true;
        overrideDevices = true;
        openDefaultPorts = true;
        settings.devices = {
            phone = {
                id = "3ZEVWIP-C5H2ZSA-LOWWCV5-LLEIRYA-3FBYCCE-IOI6XDB-YW57KG4-E6JCHAF";
                name = "Phone";
            };
            laptop = {
                id = "J4CU52T-DSNGEZV-CCKUMN5-6GWPK5U-GESTBIE-P7SC6KZ-K4XBQCZ-MRAZHAH";
                name = "Framework Laptop";
            };
            desktop = {
                id = "BH6M4CZ-7ZRTHM2-LL3IV5M-KKRWUQI-AHUEPAN-CLD373Q-6YK2P6U-55TBMA2";
                name = "Desktop";
            };
            optiplex = {
                id = "QJRN566-BEZAHOG-GPJCX32-3YEWN4E-GE4JYJ4-YYQGGVN-DFUQBLQ-KN7KZA2";
                name = "Optiplex";
            };
        };
        settings.folders = let
            devicesComputers = [
                "laptop"
                "desktop"
                "optiplex"
            ];
            devicesAll =
                [
                    "phone"
                ]
                ++ devicesComputers;
            versioningDefault = {
                type = "trashcan";
                params.cleanoutDays = "14";
            };
        in {
            "/home/pink/Pictures" = {
                label = "Computer Pictures";
                versioning = versioningDefault;
                devices = devicesComputers;
            };
            "/home/pink/Music" = {
                label = "Music";
                devices = devicesAll;
                versioning = versioningDefault;
            };
            "/home/pink/Documents/obsidian-notes" = {
                label = "Obsidian";
                devices = devicesAll;
                versioning = versioningDefault;
            };
        };
    };
}
