{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [ 
        brasero
        xfce.xfburn
    ];
}
