{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        mpc_cli
    ];

    #services.pipewire.systemWide = true;
    hardware.pulseaudio.systemWide = true;
}