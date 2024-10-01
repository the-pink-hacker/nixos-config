{ lib, vmware, pkgs, ... }:

lib.mkIf vmware {
    virtualisation.vmware.host.enable = true;
}
