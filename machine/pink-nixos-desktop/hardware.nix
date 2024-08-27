{ ... }:

{
    fileSystems."/mnt/Documents0" = {
        device = "/dev/disk/by-uuid/78e98f36-e6fb-465c-86f7-26524ebcad5b";
        fsType = "ext4";
        options = [
	    "user"
	    "users"
	    "nofail"
	];
    };

    fileSystems."/mnt/Documents1" = {
        device = "/dev/disk/by-uuid/661a481f-7f16-4f3a-8de6-f52d4de8c856";
        fsType = "ext4";
        options = [
	    "user"
	    "users"
	    "nofail"
	];
    };

    networking.hostName = "pink-nixos-desktop";
}
