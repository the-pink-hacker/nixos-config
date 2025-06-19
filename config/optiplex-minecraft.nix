{ pkgs, ... }:

{
    services.minecraft-servers = {
        enable = true;
        eula = true;
        openFirewall = true;
        servers.optiplex = {
            enable = true;
            package = pkgs.fabricServers.fabric-1.21.6;
            restart = "always";
            enableReload = true;
        };
    };
}
