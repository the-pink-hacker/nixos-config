{ configPath, ... }:

{
    imports = map (path: configPath + path) [
        /optiplex-minecraft.nix
        /ssh-host.nix
        /ftp-server.nix
    ];
}
