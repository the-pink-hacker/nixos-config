{
    lib,
    battery,
    ...
}:
lib.mkIf battery {
    services.power-profiles-daemon.enable = true;
}
