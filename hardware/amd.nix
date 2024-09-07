{ pkgs, ... }:

{
    boot.initrd.kernelModules = [ "amdgpu" ];

    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    # HIP
    systemd.tmpfiles.rules = 
    let
        rocmEnv = pkgs.symlinkJoin {
            name = "rocm-combined";
            paths = with pkgs.rocmPackages; [
                rocblas
                hipblas
                clr
            ];
        };
    in [
        "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];
    
    hardware.opengl.extraPackages = with pkgs; [
        # OpenCL
        rocmPackages.clr.icd
        # AMDVLK
        amdvlk
        mesa
    ];

    hardware.opengl.extraPackages32 = with pkgs; [
        # AMDVLK
        driversi686Linux.amdvlk
    ];

    # GUI Controller
    environment.systemPackages = with pkgs; [ lact ];
    systemd.packages = with pkgs; [ lact ];
    systemd.services.lactd.wantedBy = [ "multi-user.target" ];

    environment.variables = {
        AMD_VULKAN_ICD = "RADV";
        ROC_ENABLE_PRE_VEGA = "1";
    };
}
