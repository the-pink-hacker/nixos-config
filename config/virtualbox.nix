{vmEnable, ...}: {
    virtualisation.virtualbox.host = {
        enable = vmEnable;
        enableExtensionPack = true;
    };
}
