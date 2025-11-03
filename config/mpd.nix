{
    config,
    pkgs,
    ...
}: {
    environment.systemPackages = with pkgs; [
        mpc
    ];

    #services.pipewire.systemWide = true;
    services.pulseaudio.systemWide = true;
}
