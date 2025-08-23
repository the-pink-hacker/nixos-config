{
    pkgs,
    lib,
    ...
}: {
    environment.sessionVariables = {
        SHELL = lib.getExe pkgs.fish;
    };

    programs.fish.enable = true;
}
