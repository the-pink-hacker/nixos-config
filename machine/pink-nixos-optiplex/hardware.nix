{ configPath, ... }:

{
    imports = map (path: configPath + path) [
        /optiplex-minecraft.nix
    ];
}
