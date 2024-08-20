# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

#let
#    home-manager = builtins.fetchTarball {
#	url = "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
#	sha256 = "sha256:0c83di08nhkzq0cwc3v7aax3x8y5m7qahyzxppinzwxi3r8fnjq3";
#    };
#    #godot4-mono-test = pkgs.callPackage /home/pink/Documents/Code/Nix/nixpkgs/pkgs/development/tools/godot/4/mono {};
#in
{
    imports = [
	#./hardware-configuration.nix
        #./nvidia.nix
	#(import "${home-manager}/nixos")
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    #boot.loader.grub = {
    #	enable = true;
    #    device = "nodev";
    #    useOSProber = true;
    #    efiSupport = true;
    #};

    fileSystems."/mnt/Documents0" = {
        device = "/dev/disk/by-uuid/78e98f36-e6fb-465c-86f7-26524ebcad5b";
        fsType = "ext4";
        options = [
	    "user"
	    "users"
	    "nofail"
	];
    };

    fileSystems."/mnt/Documents1" = {
        device = "/dev/disk/by-uuid/661a481f-7f16-4f3a-8de6-f52d4de8c856";
        fsType = "ext4";
        options = [
	    "user"
	    "users"
	    "nofail"
	];
    };
    
    #networking.hostName = "pink-nixos-desktop"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    
    # Enable networking
    networking.networkmanager.enable = true;
    
    # Set your time zone.
    time.timeZone = "America/Indiana/Indianapolis";
    
    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };
    
    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;
    
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm = {
    	enable = true;
	wayland.enable = true;
    };
    services.desktopManager.plasma6.enable = true;
    
    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };
    
    # Enable CUPS to print documents.
    services.printing.enable = true;
    
    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      
        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };
    
    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;
    
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.pink = {
        isNormalUser = true;
        description = "Pink Garrett";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };

    #home-manager.useGlobalPkgs = true;
    #home-manager.users.pink = {
    # 	home.sessionVariables = {
    # 	    XDG_CACHE_HOME = "$HOME/.cache";
    # 	    XDG_CONFIG_HOME = "$HOME/.config";
    # 	    XDG_DATA_HOME = "$HOME/.local/share";
    # 	    XDG_STATE_HOME = "$HOME/.local/state";
    # 	    XDG_BIN_HOME = "$HOME/.local/bin";
    #        RUSTC_WRAPPER = "sccache";
    # 	};

    #    home.sessionPath = [
    #        "$HOME/.local/bin"
    #    ];

    #	programs.git = {
    #        enable = true;
    #	    userName = "Pink Garrett";
    #	    userEmail = "pink@thepinkhacker.com";
    #        signing = {
    #        	signByDefault = true;
    #    	key = "15BD92A4C6319F2A1847E84B4BB613B0CF20EE3D";
    #        };
    #        extraConfig = {
    #            init.defaultBranch = "main";
    #        };
    #	};

    #    programs.gh = {
    #        enable = true;
    #        gitCredentialHelper.enable = true;
    #    };

    #    programs.zsh = {
    #        enable = true;
    #        enableCompletion = true;
    #        autosuggestion.enable = true;
    #        initExtra = "source ~/.p10k.zsh";

    #        plugins = [
    #    	{                                                                                   
    #    	    name = "powerlevel10k";                                                           
    #    	    src = pkgs.zsh-powerlevel10k;                                                     
    #    	    file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";                         
    #    	}
    #        ];

    #        oh-my-zsh = {
    #            enable = true;
    #            plugins = [
    #    	    "git"
    #    	    "gh"
    #    	    "pass"
    #    	    "rust"
    #    	];
    #        };
    #    };

    #	programs.neovim = {
    #	    enable = true;
    #	    defaultEditor = true;
    #        viAlias = true;
    #        vimAlias = true;
    #        extraConfig = ''
    #            set shiftwidth=4 smarttab expandtab tabstop=8 softtabstop=0
    #            set clipboard+=unnamedplus
    #    	autocmd BufWritePre * lua vim.lsp.buf.format()
    #        '';
    #        extraLuaConfig = ''
    #            --[[
    #        	vim.api.nvim_create_autocmd("LspAttach", {
    #                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    #                callback = function(args)
    #                    local client = vim.lsp.get_client_by_id(args.data.client_id)
    #                    if client.server_capabilities.inlayHintProvider then
    #                        vim.lsp.inlay_hint.enable(args.buf, true)
    #                    end
    #                end
    #            })
    #    	--]]

    #            -- Telescope
    #    	local builtin = require("telescope.builtin")
    #    	vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    #    	vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    #    	vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    #    	vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

    #            -- Rust tools
    #    	local rt = require("rust-tools")

    #    	rt.setup({
    #    	    server = {
    #    	        on_attach = function(_, bufnr)
    #    	            -- Hover actions
    #    	            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
    #    	            -- Code action groups
    #    	            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    #    	        end,
    #    	    },
    #    	})

    #    	-- LSP Diagnostics Options Setup 
    #            local sign = function(opts)
    #                vim.fn.sign_define(opts.name, {
    #                    texthl = opts.name,
    #                    text = opts.text,
    #                    numhl = ""
    #                })
    #            end
    #            
    #            sign({name = "DiagnosticSignError", text = ""})
    #            sign({name = "DiagnosticSignWarn", text = ""})
    #            sign({name = "DiagnosticSignHint", text = ""})
    #            sign({name = "DiagnosticSignInfo", text = ""})
    #            
    #            vim.diagnostic.config({
    #                virtual_text = false,
    #                signs = true,
    #                update_in_insert = true,
    #                underline = true,
    #                severity_sort = false,
    #                float = {
    #                    border = "rounded",
    #                    source = "always",
    #                    header = "",
    #                    prefix = "",
    #                },
    #            })
    #            
    #            vim.cmd([[
    #                set signcolumn=yes
    #                autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
    #            ]])

    #    	--Set completeopt to have a better completion experience
    #    	-- :help completeopt
    #    	-- menuone: popup even when there's only one match
    #    	-- noinsert: Do not insert text until a selection is made
    #    	-- noselect: Do not select, force to select one from the menu
    #    	-- shortness: avoid showing extra messages when using completion
    #    	-- updatetime: set updatetime for CursorHold
    #    	vim.opt.completeopt = {"menuone", "noselect", "noinsert"}
    #    	vim.opt.shortmess = vim.opt.shortmess + { c = true}
    #    	vim.api.nvim_set_option("updatetime", 300) 
    #    	
    #    	-- Fixed column for diagnostics to appear
    #    	-- Show autodiagnostic popup on cursor hover_range
    #    	-- Goto previous / next diagnostic warning / error 
    #    	-- Show inlay_hints more frequently 
    #    	vim.cmd([[
    #    	    set signcolumn=yes
    #    	    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
    #    	]])

    #    	-- Treesitter Plugin Setup 
    #    	require("nvim-treesitter.configs").setup {
    #    	    highlight = {
    #    	        enable = true,
    #    	        additional_vim_regex_highlighting=false,
    #    	    },
    #    	    ident = { enable = true }, 
    #    	    rainbow = {
    #    	        enable = true,
    #    	        extended_mode = true,
    #    	        max_file_lines = nil,
    #    	    }
    #    	}

    #    	-- Completion Plugin Setup
    #    	local cmp = require"cmp"
    #    	cmp.setup({
    #    	  -- Enable LSP snippets
    #    	  snippet = {
    #    	    expand = function(args)
    #    	        vim.fn["vsnip#anonymous"](args.body)
    #    	    end,
    #    	  },
    #    	  mapping = {
    #    	    ["<C-p>"] = cmp.mapping.select_prev_item(),
    #    	    ["<C-n>"] = cmp.mapping.select_next_item(),
    #    	    -- Add tab support
    #    	    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    #    	    ["<Tab>"] = cmp.mapping.select_next_item(),
    #    	    ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
    #    	    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    #    	    ["<C-Space>"] = cmp.mapping.complete(),
    #    	    ["<C-e>"] = cmp.mapping.close(),
    #    	    ["<CR>"] = cmp.mapping.confirm({
    #    	      behavior = cmp.ConfirmBehavior.Insert,
    #    	      select = true,
    #    	    })
    #    	  },
    #    	  -- Installed sources:
    #    	  sources = {
    #    	    { name = "path" },                              -- file paths
    #    	    { name = "nvim_lsp", keyword_length = 3 },      -- from language server
    #    	    { name = "nvim_lsp_signature_help"},            -- display function signatures with current parameter emphasized
    #    	    { name = "nvim_lua", keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    #    	    { name = "buffer", keyword_length = 2 },        -- source current buffer
    #    	    { name = "vsnip", keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    #    	    { name = "calc"},                               -- source for math calculation
    #    	  },
    #    	  window = {
    #    	      completion = cmp.config.window.bordered(),
    #    	      documentation = cmp.config.window.bordered(),
    #    	  },
    #    	  formatting = {
    #    	      fields = {"menu", "abbr", "kind"},
    #    	      format = function(entry, item)
    #    	          local menu_icon ={
    #    	              nvim_lsp = "λ",
    #    	              vsnip = "⋗",
    #    	              buffer = "Ω",
    #    	              path = "🖫",
    #    	          }
    #    	          item.menu = menu_icon[entry.source.name]
    #    	          return item
    #    	      end,
    #    	  },
    #    	})
    #        '';
    #        withPython3 = true;
    #        withNodeJs = true;

    #        plugins = with pkgs.vimPlugins; [
    #        	rust-tools-nvim
    #    	#rustaceanvim
    #            nvim-treesitter
    #            nvim-treesitter-parsers.rust
    #    	nvim-treesitter-parsers.json
    #    	nvim-treesitter-parsers.toml
    #    	nvim-treesitter-parsers.python
    #    	nvim-treesitter-parsers.nix
    #    	nvim-lspconfig
    #    	nvim-dap
    #    	nvim-autopairs
    #    	#statix
    #    	plenary-nvim
    #    	telescope-nvim
    #    	vimagit
    #    	nvim-cmp
    #    	cmp-nvim-lsp
    #    	vim-vsnip
    #        ];
    #	};

    #    services.gpg-agent = {
    #        enable = true;
    #        enableZshIntegration = true;
    #        grabKeyboardAndMouse = true;
    #        pinentryPackage = pkgs.pinentry-qt;
    #    };

    #    programs.obs-studio = {
    #        enable = true;
    #    };

    #    services.espanso = {
    #        enable = true;
    #        package = pkgs.espanso-wayland;
    #        matches = {
    #            default = {
    #                matches = [
    #                    # === Symbols ===
    #                    # Misc
    #                    { trigger = ":..."; replace = "…"; }
    #                    { trigger = ":<="; replace = "≤"; }
    #                    { trigger = ":>="; replace = "≥"; }
    #                    { regex = ":(!|/)="; replace = "≠"; }
    #                    { trigger = ":~="; replace = "≈"; }
    #                    { trigger = ":--"; replace = "—"; }
    #                    { trigger = ":o~"; replace = "⧜"; }
    #                    { trigger = ":oo"; replace = "∞"; }
    #                    { regex = ":o(/|\\|)o"; replace = "⧞"; }
    #                    { trigger = ":multiply"; replace = "×"; }
    #                    { trigger = ":divide"; replace = "÷"; }
    #                    { trigger = ":degree"; replace = "°"; }
    #                    
    #                    
    #                    # Superscripts
    #                    { trigger = ":^0"; replace = "⁰"; }
    #                    { trigger = ":^1"; replace = "¹"; }
    #                    { trigger = ":^2"; replace = "²"; }
    #                    { trigger = ":^3"; replace = "³"; }
    #                    { trigger = ":^4"; replace = "⁴"; }
    #                    { trigger = ":^5"; replace = "⁵"; }
    #                    { trigger = ":^6"; replace = "⁶"; }
    #                    { trigger = ":^7"; replace = "⁷"; }
    #                    { trigger = ":^8"; replace = "⁸"; }
    #                    { trigger = ":^9"; replace = "⁹"; }
    #                    
    #                    # === Emojies ===;
    #                    # Hearts;
    #                    { regex = ":<(\\||/|\\\\)3"; replace = "💔"; }
    #                    { regex = ":(|red)<3"; replace = "❤️"; }
    #                    { trigger = ":pink<3"; replace = "🩷"; }
    #                    { trigger = ":orange<3"; replace = "🧡"; }
    #                    { trigger = ":yellow<3"; replace = "💛"; }
    #                    { trigger = ":green<3"; replace = "💚"; }
    #                    { trigger = ":blue<3"; replace = "💙"; }
    #                    { regex = ":(azure|aqua|light blue)<3"; replace = "🩵"; }
    #                    { trigger = ":purple<3"; replace = "💜"; }
    #                    { trigger = ":brown<3"; replace = "🤎"; }
    #                    { trigger = ":black<3"; replace = "🖤"; }
    #                    { regex = ":(gray|grey)<3"; replace = "🩶"; }
    #                    { trigger = ":white<3"; replace = "🤍"; }
    #                ];
    #            };
    #        };
    #    };

    #	programs.java = {
    #	    enable = true;
    #	    package = pkgs.jdk8;
    #	};

    #    xdg.desktopEntries = {
    #        blockbench = {
    #        	name = "Blockbench";
    #    	genericName = "Voxel Model Maker";
    #            exec = "blockbench %U --enable-features=UseOzonePlatform,WaylandWindoDecorations,WebRTCPipeWireCapture --ozone-platform=wayland";
    #    	categories = [ "Graphics" "3DGraphics" ];
    #    	comment = "Low-poly 3D modeling and animation software";
    #    	icon = "blockbench";
    #    	terminal = false;
    #    	type = "Application";
    #    	settings = {
    #    	    StartupWMClass = "Blockbench";
    #    	};
    #        };
    #    };

    #	home.stateVersion = "24.05";
    #};

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    #nixpkgs.overlays = [(self: super: {
    #    espanso-wayland = super.espanso-wayland.overrideAttrs (old: rec {
    #        version = "2";
    #        src = super.fetchFromGitHub {
    #            owner = "espanso";
    #            repo = "espanso";
    #            rev = "v2.2.1";
    #            sha256 = "sha256-41oF7aBxCy+Vbm1Tbx2qMkdywxVJpnH/kmKMtpgvWwc=";
    #        };
    #        cargoDeps = super.espanso-wayland.cargoDeps.overrideAttrs (_: {
    #            inherit src;
    #            #outputHash = "sha256-UXH0SstMVprgezyr3I/6rv2uCMdDUUSIsQ3MJ49tdoI=";
    #            hash = "";
    #        });
    #    });
    #})];
    
    programs.firefox = {
        enable = true;
        nativeMessagingHosts.packages = with pkgs; [ passff-host ];
    };
    
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
    	(pass.withExtensions (exts: with exts; [ pass-otp ]))
	os-prober
	ripgrep
	fd
	tree-sitter
        gh
        neovim
	vscode
	gnupg1
	spotify
	discord
	pinentry-qt
	neofetch
	tokodon
	wl-clipboard-rs
	kdeconnect
	blockbench
	#vlc
	atlauncher
	(python3.withPackages (python-pkgs: with python-pkgs; [
	    upnpy
	    hjson
	    pillow
	]))
	glfw
	openal
	rustup
	sccache
	clang
	cmake
	tree
	obsidian
	gimp
	firewalld
	thunderbird
	gnome.ghex
	wine
	winetricks
	mono
	#godot4-mono-test
	gnumake
	#dotnet-sdk_8
	#dotnet-runtime_8
	#speechd
	#libdecor
	#wayland-scanner
	blender
	#msbuild
    ];

    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
	extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;
    #programs.gnupg.agent = {
    #    enable = true;
    #    enableSSHSupport = true;
    #};

    fonts = {
    	enableDefaultPackages = false;
        fontDir.enable = true;
        packages = with pkgs; [
            powerline-fonts
            noto-fonts
            noto-fonts-emoji
            noto-fonts-cjk
        ];

	fontconfig = {
	    defaultFonts = {
                serif = [ "Noto Serif" ];
                sansSerif = [ "Noto Sans" ];
                monospace = [ "Meslo LG L DZ for Powerline" ];
                emoji = [ "Noto Emoji" ];
            };
	};
    };
    
    
    # List services that you want to enable:
    services.dbus.packages = with pkgs; [
        gcr # For GPG pinentry
    ];

    # GPG
    services.pcscd.enable = true;

    security.sudo-rs.enable = true;

    # Fix windows time issue
    time.hardwareClockInLocalTime = true;

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
    
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    networking.firewall = {
    	enable = true;
    };

    networking.nftables.enable = true;
    
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
}
