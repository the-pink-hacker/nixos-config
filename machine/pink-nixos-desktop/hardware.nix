{...}: {
    fileSystems = let
        options = [
            "user"
            "users"
            "nofail"
            "exec"
        ];
        fsType = "ext4";
    in {
        "/run/media/pink/Documents0" = {
            device = "/dev/disk/by-uuid/78e98f36-e6fb-465c-86f7-26524ebcad5b";
            inherit options fsType;
        };
        "/run/media/pink/Documents1" = {
            device = "/dev/disk/by-uuid/661a481f-7f16-4f3a-8de6-f52d4de8c856";
            inherit options fsType;
        };
        "/run/media/pink/Documents2" = {
            device = "/dev/disk/by-uuid/203571a4-dd0b-4f2f-a83b-0a216984b9fc";
            inherit options fsType;
        };
    };
}
