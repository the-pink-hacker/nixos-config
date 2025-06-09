{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [ 
        brasero
        dvdplusrwtools
        xfce.xfburn
        kdePackages.k3b
    ];
}
