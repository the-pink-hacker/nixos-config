{ pkgs, ... }:

{
    home.packages = with pkgs; [
        kitty
    ];

    programs.kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;
        font = {
            name = "Meslo LG L DZ for Powerline";
            size = 10;
        };
    };
}
