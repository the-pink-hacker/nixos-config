{
    pkgs,
    lib,
    vmEnable,
    ...
}:
lib.mkIf vmEnable {
    virtualisation.libvirtd = {
        enable = true;
        qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };
    virtualisation.spiceUSBRedirection.enable = true;
    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = ["pink"];
    users.users.pink.extraGroups = ["libvirtd"];
}
