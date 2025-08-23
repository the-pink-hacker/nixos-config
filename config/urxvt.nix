{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        rxvt-unicode-emoji
    ];

    services.urxvtd.enable = true;
}
