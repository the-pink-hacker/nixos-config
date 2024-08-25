{ pkgs, unstable, ... }:

{
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
            RUSTC_WRAPPER = "sccache";
        };
    };

     programs.neovim = {
         enable = true;
         # UNSTABLE: Inlay hints
         package = unstable.neovim-unwrapped;
         defaultEditor = true;
         viAlias = true;
         vimAlias = true;
         extraLuaConfig = builtins.readFile ../../config/neovim/extra.lua;
         withPython3 = true;
         withNodeJs = true;
         plugins = with pkgs.vimPlugins; [
     	    rustaceanvim
            nvim-treesitter
            nvim-treesitter-parsers.rust
     	    nvim-treesitter-parsers.json
     	    nvim-treesitter-parsers.toml
     	    nvim-treesitter-parsers.python
     	    nvim-treesitter-parsers.nix
     	    nvim-lspconfig
     	    nvim-dap
     	    nvim-autopairs
     	    plenary-nvim
     	    telescope-nvim
     	    vimagit
     	    nvim-cmp
     	    cmp-nvim-lsp
     	    vim-vsnip
         ];
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
    
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        initExtra = "source ~/.p10k.zsh";
    
        plugins = [
    	    {                                                                                   
    	        name = "powerlevel10k";                                                           
    	        src = pkgs.zsh-powerlevel10k;                                                     
    	        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";                         
    	    }
        ];
    
        oh-my-zsh = {
            enable = true;
            plugins = [
    	        "git"
    	        "gh"
    	        "pass"
    	        "rust"
    	    ];
        };
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
    
    services.espanso = {
        enable = true;
        # UNSTABLE: Fix crash on startup
        package = unstable.espanso-wayland;
        configs = {
            default = {
                keyboard_layout = {
                    layout = "us";
                    rules = "evdev";
                    model = "pc105";
                };
            };
        };
        matches = {
            default = import ../../config/espanso/default.nix;
        };
    };
    
    programs.java = {
        enable = true;
        package = pkgs.jdk22;
    };
    
    xdg.desktopEntries = {
        blockbench = {
            name = "Blockbench";
    	    genericName = "Voxel Model Maker";
            exec = "blockbench %U --enable-features=UseOzonePlatform,WaylandWindoDecorations,WebRTCPipeWireCapture --ozone-platform=wayland";
    	    categories = [ "Graphics" "3DGraphics" ];
    	    comment = "Low-poly 3D modeling and animation software";
    	    icon = "blockbench";
    	    terminal = false;
    	    type = "Application";
    	    settings = {
    	        StartupWMClass = "Blockbench";
    	    };
        };
    };
    
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
}
