{ syncthingEnable, ... }:

{
    services.syncthing = {
        enable = syncthingEnable;
        overrideFolders = true;
        overrideDevices = true;
        settings.devices = {
            phone = {
                id = "3ZEVWIP-C5H2ZSA-LOWWCV5-LLEIRYA-3FBYCCE-IOI6XDB-YW57KG4-E6JCHAF";
                name = "Phone";
            };
            laptop = {
                id = "FTUP4B4-Z222AS2-ZTNS5QN-A3NR2GC-BRTPILY-ZL5QVSP-7HFWADD-VPTBOQK";
                name = "Framework Laptop";
            };
            desktop = {
                id = "BH6M4CZ-7ZRTHM2-LL3IV5M-KKRWUQI-AHUEPAN-CLD373Q-6YK2P6U-55TBMA2";
                name = "Desktop";
            };
        };
        settings.folders = let 
            devicesComputers = [
                "laptop"
                "desktop"
            ];
            devicesAll = [
                "phone"
            ] ++ devicesComputers;
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
