{
    vmEnable,
    lib,
    ...
}:
lib.mkIf vmEnable {
    dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
            autoconnect = ["qemu:///system"];
            uris = ["qemu:///system"];
        };
    };
}
