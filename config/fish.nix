{
    pkgs,
    lib,
    ...
}: {
    environment.sessionVariables = {
        SHELL = lib.getExe pkgs.fish;
        EDITOR = "nvim";
    };

    programs.fish.enable = true;
}
