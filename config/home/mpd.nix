{ ... }:

{
    services.mpd = {
        enable = true;
        extraConfig = ''
            audio_output {
                type "pulse"
                name "Pulse Audio"
            }
        '';
        #extraConfig = ''
        #    audio_output {
        #        type "pipewire"
        #        name "PipeWire"
        #    }
        #'';
    };

    programs.ncmpcpp = {
        enable = true;
        bindings = [
            { key = "j"; command = "scroll_down"; }
            { key = "k"; command = "scroll_up"; }
            { key = "J"; command = [ "select_item" "scroll_down" ]; }
            { key = "K"; command = [ "select_item" "scroll_up" ]; }
        ];
    };

    services.mpd-discord-rpc = {
        settings = {
            id = 677226551607033903;
            hosts = [
                "127.0.0.1:6600"
            ];
            format = {
                details = "$title";
                state = "$artist | $album [$duration]";
                timestamp = "elapsed";
                large_image = "notes";
                small_image = "notes";
                large_text = "";
                small_text = "MPD on NixOS";
            };
        };
    };
}
