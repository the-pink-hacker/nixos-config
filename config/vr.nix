{ lib, pkgs, vr, ... }:

# SteamVR command:
# WAYLAND_DISPLAY='' QT_QPA_PLATFORM=xcb ~/.local/share/Steam/steamapps/common/SteamVR/bin/vrmonitor.sh %command%

lib.mkIf vr {
    environment.systemPackages = with pkgs; [
        sidequest
        beatsabermodmanager
    ];

    programs.alvr = {
        enable = true;
        openFirewall = true;
    };

    programs.adb.enable = true;

    # sudo setcap CAP_SYS_NICE+ep ~/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher
    boot.kernelPatches = [
        {
            name = "amdgpu-ignore-ctx-privileges";
            patch = pkgs.fetchpatch {
                name = "cap_sys_nice_begone.patch";
                url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
                hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
            };
        }
    ];
}
