{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        mpc_cli
    ];

    # PulseAudio workaround
    hardware.pulseaudio.systemWide = true;
}
