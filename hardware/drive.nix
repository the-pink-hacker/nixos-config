{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [ 
        brasero
        xfburn
    ];
}
