# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

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
    
    # Enable networking
    networking = {
        hostName = "pink-nixos-desktop";
        networkmanager.enable = true;
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
    };
    
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.pink = {
        isNormalUser = true;
        description = "Pink Garrett";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

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
	gnumake
	blender
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

    networking.firewall = {
    	enable = true;
    };

    networking.nftables.enable = true;
    
    system.stateVersion = "24.05";
}
