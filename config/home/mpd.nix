{ ... }:

{
    services.mpd = {
        enable = true;
        extraConfig = ''
            audio_output {
                type "pulse"
                name "Pulseaudio"
            }
        '';
    };
}
