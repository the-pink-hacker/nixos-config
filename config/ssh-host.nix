{ ... }:

{
    services.openssh = {
        enable = true;
        openFirewall = true;
    };

    programs.gnupg.agent.enableSSHSupport = true;
}
