{ ... }:

let
    driveOptions = [
	"user"
	"users"
	"nofail"
        "exec"
    ];
in {
    fileSystems."/run/media/pink/Documents0" = {
        device = "/dev/disk/by-uuid/78e98f36-e6fb-465c-86f7-26524ebcad5b";
        fsType = "ext4";
        options = driveOptions;
    };

    fileSystems."/run/media/pink/Documents1" = {
        device = "/dev/disk/by-uuid/661a481f-7f16-4f3a-8de6-f52d4de8c856";
        fsType = "ext4";
        options = driveOptions;
    };

    networking.hostName = "pink-nixos-desktop";
}
