{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        # chrome://flags/#enable-unsafe-webgpu
        (chromium.override {
            enableWideVine = false;
            commandLineArgs = [
                "--enable-features=AcceleratedVideoEncoder,VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE"
                "--ignore-gpu-blocklist"
                "--enable-zero-copy"
            ];
        })
    ];
}
