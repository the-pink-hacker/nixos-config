{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        brasero
        dvdplusrwtools
        xfce.xfburn
    ];

    programs.k3b.enable = true;
}
