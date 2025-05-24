{ pkgs, ... }:

{
    services.gpg-agent.enableFishIntegration = true;
    programs.kitty.shellIntegration.enableFishIntegration = true;
    programs.yazi.enableFishIntegration = true;
    programs.eza.enableFishIntegration = true;
    programs.zoxide.enableFishIntegration = true;

    programs.fish = {
        enable = true;
        plugins = [
            {
                name = "theme-bobthefish";
                src = pkgs.fetchFromGitHub {
                    owner = "oh-my-fish";
                    repo = "theme-bobthefish";
                    rev = "e3b4d4eafc23516e35f162686f08a42edf844e40";
                    hash = "sha256-cXOYvdn74H4rkMWSC7G6bT4wa9d3/3vRnKed2ixRnuA=";
                };
            }
            #{
            #    name = "theme-agnoster";
            #    src = pkgs.fetchFromGitHub {
            #        owner = "oh-my-fish";
            #        repo = "theme-agnoster";
            #        rev = "4c5518c89ebcef393ef154c9f576a52651400d27";
            #        hash = "sha256-OFESuesnfqhXM0aij+79kdxjp4xgCt28YwTrcwQhFMU=";
            #    };
            #}
        ];
        shellInit = "set -g theme_color_scheme terminal";
    };
}
