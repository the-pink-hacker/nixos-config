{ pkgs, ... }:

{
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

    # HIP
    systemd.tmpfiles.rules = [
        "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

    hardware.opengl = {
        enable = true;
        driSupport32Bit = true; # For 32 bit applications
    };

    # AMDVLK
    hardware.opengl.extraPackages = with pkgs; [
        amdvlk
    ];
    # For 32 bit applications 
    hardware.opengl.extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
    ];
}
