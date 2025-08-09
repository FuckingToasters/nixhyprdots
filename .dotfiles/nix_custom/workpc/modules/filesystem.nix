{ config, pkgs, ... }:

{
  # File System

  fileSystems."/smssd" = {
    device = "/dev/disk/by-uuid/3dbd2939-f90f-4551-aecb-c7d16217cab7";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };

  # NFS


  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /smssd *(rw,nohide,insecure,no_subtree_check,sync,all_squash,anonuid=1000,anongid=1000)
  '';

   # Allow NFS traffic through the firewall
   networking.firewall.allowedTCPPorts = [ 2049 111 ];
   networking.firewall.allowedUDPPorts = [ 2049 111 ];
   networking.firewall.allowedTCPPortRanges = [
     { from = 32765; to = 32769; }
   ];
   networking.firewall.allowedUDPPortRanges = [
     { from = 32765; to = 32769; }
   ];


    fileSystems."/mnt/media" = {
      device = "100.114.145.128:/mnt/media";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" "rw" "vers=4" ];
    };

    fileSystems."/mnt/stuff" = {
      device = "100.114.145.128:/mnt/stuff";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" "rw" "vers=4" ];
    };

    fileSystems."/mnt/hub" = {
      device = "100.114.145.128:/mnt/hub";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" "rw" "vers=4" ];
    };

    fileSystems."/mnt/backups" = {
      device = "100.114.145.128:/backups";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" "rw" "vers=4" ];
    };

}
