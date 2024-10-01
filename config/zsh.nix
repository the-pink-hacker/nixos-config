{ pkgs, ... }:

{
    programs.zsh.enable = true;
    environment.sessionVariables = {
        SHELL = "${pkgs.zsh}/bin/zsh";
    };
}
