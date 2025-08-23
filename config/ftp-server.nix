{...}: {
    services.vsftpd = {
        enable = true;
        localUsers = true;
        writeEnable = true;
    };
}
