{ pkgs, homeConfigPath, ... }:

{
    imports = builtins.map (path: homeConfigPath + path) [
        /blockbench.nix
        /discord.nix
        /espanso.nix
        /hyprland.nix
        /neovim.nix
        /mpd.nix
        /firefox.nix
        #/urxvt.nix
        /zsh.nix
    ];

    home = {
    	username = "pink";
        homeDirectory = "/home/pink";
        sessionPath = [
            "$HOME/.local/bin"
        ];
        sessionVariables = {
            XDG_CACHE_HOME = "$HOME/.cache";
            XDG_CONFIG_HOME = "$HOME/.config";
            XDG_DATA_HOME = "$HOME/.local/share";
            XDG_STATE_HOME = "$HOME/.local/state";
            XDG_BIN_HOME = "$HOME/.local/bin";
        };
    };

    programs.git = {
        enable = true;
        userName = "Pink Garrett";
        userEmail = "pink@thepinkhacker.com";
        signing = {
            signByDefault = true;
    	    key = "15BD92A4C6319F2A1847E84B4BB613B0CF20EE3D";
        };
        extraConfig = {
            init.defaultBranch = "main";
        };
    };

    programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
    };

    services.gpg-agent = {
        enable = true;
        enableZshIntegration = true;
        grabKeyboardAndMouse = true;
        pinentryPackage = pkgs.pinentry-qt;
    };

    programs.obs-studio = {
        enable = true;
    };

    programs.java = {
        enable = true;
        package = pkgs.jdk23;
    };

    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
}
