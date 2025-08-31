{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        fluffychat
    ];

    nixpkgs.config.permittedInsecurePackages = [
        "fluffychat-linux-1.27.0"
        "olm-3.2.16"
    ];
}
