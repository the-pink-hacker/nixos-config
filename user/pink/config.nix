{
    pkgs,
    configPath,
    config,
    theme,
    gui,
    lib,
    inputs,
    ...
}: {
    imports =
        (map (path: configPath + path) ([
            /battery.nix
            /mpd.nix
            /urxvt.nix
            #/zsh.nix
            /cloudflare.nix
            /minecraft.nix
            /gamemode.nix
            /fish.nix
            /syncthing.nix
        ]
        ++ lib.optionals gui [
            /hyprland.nix
            /vr.nix
            #/vmware.nix
            #/virtualbox.nix
            /virt-manager.nix
            /chromium.nix
            /matrix-client.nix
        ]))
        ++ [
            inputs.nix-minecraft.nixosModules.minecraft-servers
        ];

    boot = {
        loader = {
            systemd-boot.enable = false;
            efi.canTouchEfiVariables = true;
            grub = {
                enable = true;
                efiSupport = true;
                device = "nodev";
                minegrub-world-sel = {
                    enable = true;
                    customIcons = [
                        {
                            name = "nixos";
                            lineTop = "NixOS (23/11/2023, 23:03)";
                            lineBottom = "Survival Mode, No Cheats, Version: 23.11";
                            # Icon: you can use an icon from the remote repo, or load from a local file
                            imgName = "nixos";
                            # customImg = builtins.path {
                            #   path = ./nixos-logo.png;
                            #   name = "nixos-img";
                            # };
                        }
                    ];
                };
            };
        };
        supportedFilesystems = [
            "fat32"
            "exfat"
            "ntfs"
        ];
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Enable networking
    networking = {
        networkmanager = {
            enable = true;
            wifi.backend = "iwd";
        };
        wireguard.enable = true;
        wireless.iwd = {
            enable = true;
            settings = {
                IPv6.Enabled = true;
                Settings.AutoConnect = true;
                General.AddressRandomization = true;
            };
        };
    };

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
    services.xserver.enable = false;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    users.users.pink = {
        isNormalUser = true;
        description = "Pink Garrett";
        extraGroups = [
            "networkmanager"
            "wheel"
            "input"
            "video"
            "disk"
            "gamemode"
            "cdrom"
        ];
        packages = with pkgs;
            [
                dust
                cargo-info
                rusty-man
                tokei
                wiki-tui
                mprocs
                presenterm
                neofetch
                winetricks
                wineWow64Packages.waylandFull
                clinfo
                virtualgl
                vulkan-tools
                wayland-utils
                pciutils
                aha
                fwupd
                #vobcopy
                kdePackages.kdeconnect-kde
                tmux
            ]
            ++ lib.optionals gui [
                heroic
                vscode
                libreoffice-qt
                vlc
                obsidian
                gimp
                thunderbird
                ghex
                blender
                xorg.xeyes
                kdePackages.tokodon
                kdePackages.dolphin
                #elisa
                protonvpn-gui
                mangohud
                jetbrains.idea-community-bin
                kdePackages.kcharselect
                krita
                tenacity
                cemu-ti
                openttd
                signal-desktop
            ];
    };

    programs.kdeconnect.enable = true;

    environment.systemPackages = with pkgs;
        [
            (pass-wayland.withExtensions (exts: with exts; [pass-otp]))
            os-prober
            ripgrep
            fd
            tree-sitter
            gh
            neovim
            gnupg1
            wl-clipboard-rs
            (python3.withPackages (python-pkgs:
                with python-pkgs; [
                    upnpy
                    numpy
                    miniupnpc
                    hjson
                    pillow
                    requests
                    tkinter
                    jsonschema
                ]))
            clang
            cmake
            tree
            firewalld
            mono
            gnumake
            ffmpeg
        ]
        ++ lib.optionals gui [
            pinentry-qt
            hunspell
            hunspellDicts.en_US
        ];

    #programs.ssh.startAgent = true;

    xdg.portal = {
        enable = gui;
        extraPortals = with pkgs; [
            kdePackages.xdg-desktop-portal-kde
            xdg-desktop-portal-gtk
        ];
    };

    programs.steam = {
        enable = gui;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        extraCompatPackages = with pkgs; [proton-ge-bin];
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;

    fonts = {
        enableDefaultPackages = false;
        fontDir.enable = true;
        packages = with pkgs;
            [
                arkpandora_ttf
                powerline-fonts
                noto-fonts
                noto-fonts-color-emoji
                noto-fonts-cjk-sans
                font-awesome
            ]
            ++ [
                theme.fonts.monospace.package
            ];

        fontconfig = {
            defaultFonts = {
                serif = ["Tymes" "Noto Serif"];
                sansSerif = ["Noto Sans" "Aerial"];
                monospace = [theme.fonts.monospace.name];
                emoji = ["Noto Color Emoji"];
            };
        };
    };

    # List services that you want to enable:
    services.dbus.packages = with pkgs; [
        gcr # For GPG pinentry
    ];

    # GPG
    services.pcscd.enable = true;

    security.sudo.enable = true;

    # Fix windows time issue
    #time.hardwareClockInLocalTime = true;

    networking.firewall = {
        enable = true;
    };

    networking.nftables.enable = true;

    # Use normal linux binaries
    programs.nix-ld.enable = true;

    hardware.enableAllFirmware = true;

    system.stateVersion = "24.05";
}
