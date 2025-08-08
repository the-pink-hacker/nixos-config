{ pkgs, ... }:

let
    extraPackages = builtins.concatStringsSep " " [
        "xorg.libX11"
        "xorg.libXcursor"
        "xorg.libXrandr"
        "xorg.libXxf86vm"
        "xorg.libXext"
        "flite"
        "libusb1"
        "libxkbcommon"
        "wayland"
        "egl-wayland"
        "libGL"
        "libpulseaudio"
        "openal"
        "vulkan-loader"
        "gradle"
    ];
in {
    xdg.desktopEntries = {
        idea-community-minecraft = {
            name = "IntelliJ IDEA CE Minecraft";
    	    genericName = "Free Java, Kotlin, Groovy and Scala IDE from jetbrains";
            # This is so hacky but it works I guess
            exec = "nix-shell -p ${extraPackages} --run \"idea-community -Dawt.toolkit.name=WLToolkit\"";
    	    categories = [
                "Development"
            ];
    	    comment = "IDE for Java SE, Groovy & Scala development Powerful environment for building Google Android apps Integration with JUnit, TestNG, popular SCMs, Ant & Maven. Also known as IntelliJ.";
    	    icon = "idea-community";
    	    terminal = false;
    	    type = "Application";
    	    settings = {
                StartupWMClass = "jetbrains-idea-ce";
    	    };
        };
    };
}
