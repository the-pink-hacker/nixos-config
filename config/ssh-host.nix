{ ... }:

let 
    port = 64102;
in {
    services.openssh = {
        enable = true;
        openFirewall = true;
        ports = [
            port
        ];
        settings = {
            #KbdInteractiveAuthentication = false;
            #PasswordAuthentication = false;
            PermitRootLogin = "no";
            AllowUsers = [
                "pink"
            ];
        };
    };

    programs.gnupg.agent.enableSSHSupport = true;

    #services.fail2ban.enable = true;

    services.endlessh = {
        enable = true;
        openFirewall = true;
        port = 22;
    };
}
