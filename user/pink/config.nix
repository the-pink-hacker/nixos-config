{ pkgs, ... }:

{
    imports = [
        ../../config/hyprland.nix
        ../../config/battery.nix
        ../../config/vr.nix
        ../../config/vmware.nix
        #../../config/urxvt.nix
        ../../config/zsh.nix
    ];

    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
        supportedFilesystems = [
            "fat32"
            "exfat"
            "ntfs"
        ];
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
        ];
        packages = with pkgs; [
            libreoffice-qt
	    vscode
	    vlc
	    spotify
	    neofetch
	    atlauncher
	    glfw
	    openal
	    obsidian
	    gimp
	    thunderbird
	    ghex
	    winetricks
            wineWowPackages.waylandFull
	    blender
            xorg.xeyes
            clinfo
            virtualgl
            vulkan-tools
            wayland-utils
            pciutils
            aha
            fwupd
	    tokodon
            dolphin
            elisa
            protonvpn-gui
            heroic
            gamemode
            mangohud
        ];
    };

    programs.kdeconnect.enable = true;

    environment.systemPackages = with pkgs; [
    	(pass.withExtensions (exts: with exts; [ pass-otp ]))
	os-prober
	ripgrep
	fd
	tree-sitter
        gh
        neovim
	gnupg1
	pinentry-qt
	wl-clipboard-rs
	(python3.withPackages (python-pkgs: with python-pkgs; [
	    upnpy
	    hjson
	    pillow
            requests
            tkinter
            jsonschema
	]))
	rustup
	sccache
	clang
	cmake
	tree
	firewalld
	mono
	gnumake
        hunspell
        hunspellDicts.en_US
        ffmpeg
    ];

    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
            kdePackages.xdg-desktop-portal-kde
            xdg-desktop-portal-gtk
        ];
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

    fonts = {
    	enableDefaultPackages = false;
        fontDir.enable = true;
        packages = with pkgs; [
            powerline-fonts
            noto-fonts
            noto-fonts-color-emoji
            noto-fonts-cjk
            font-awesome
        ];

	fontconfig = {
	    defaultFonts = {
                serif = [ "Noto Serif" ];
                sansSerif = [ "Noto Sans" ];
                monospace = [ "Meslo LG L DZ for Powerline" ];
                emoji = [ "Noto Color Emoji" ];
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

    networking.firewall = {
    	enable = true;
    };

    networking.nftables.enable = true;

    # Use normal linux binaries
    programs.nix-ld.enable = true;
    
    system.stateVersion = "24.05";
}
