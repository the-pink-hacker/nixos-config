{ pkgs, ... }:

{
    home.packages = [ pkgs.blockbench ];

    xdg.configFile."Blockbench/launch_settings.json".source = ./blockbench/launch_settings.json;

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
}
