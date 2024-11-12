{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
	atlauncher
        prismlauncher
    ];
}
