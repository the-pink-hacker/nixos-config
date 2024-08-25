{ pkgs, config, libs, ... }:

{
    # Enable OpenGL
    hardware.opengl = {
        enable = true;
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = ["nvidia"];
    
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;

        package = config.boot.kernelPackages.nvidiaPackages.production;
    };
}
