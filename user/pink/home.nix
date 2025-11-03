{
    pkgs,
    homeConfigPath,
    gui,
    lib,
    ...
}: {
    imports = map (path: homeConfigPath + path) ([
        /neovim.nix
        #/urxvt.nix
        #/zsh.nix
        /fish.nix
        #/helix.nix
    ]
    ++ lib.optionals gui [
        /mpd.nix
        /blockbench.nix
        /discord.nix
        /espanso.nix
        /hyprland.nix
        /yazi.nix
        /firefox.nix
        /idea.nix
        /virt-manager.nix
    ]);

    xdg.userDirs = {
        enable = true;
        createDirectories = true;
    };

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
        shellAliases = {
            ls = "eza";
            cat = "bat";
        };
    };

    programs.git = {
        enable = true;
        signing = {
            signByDefault = true;
            key = "15BD92A4C6319F2A1847E84B4BB613B0CF20EE3D";
        };
        settings = {
            user = {
                name = "Pink Garrett";
                email = "pink@thepinkhacker.com";
            };
            init.defaultBranch = "main";
        };
    };

    programs.delta.enableGitIntegration = true;

    programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
    };

    programs.ripgrep.enable = true;

    programs.bat.enable = true;

    programs.eza.enable = true;

    programs.zoxide.enable = true;

    programs.bacon.enable = true;

    services.gpg-agent = {
        enable = true;
        grabKeyboardAndMouse = true;
        pinentry.package = pkgs.pinentry-qt;
        enableSshSupport = true;
    };

    programs.obs-studio = {
        enable = gui;
    };

    programs.java = {
        enable = true;
        package = pkgs.jdk25;
    };

    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
}
