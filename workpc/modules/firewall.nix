{ config, pkgs, ... }:

{
   # Allow NFS & localsend traffic through the firewall
   networking.firewall.allowedTCPPorts = [ 2049 111 53317 ];
   networking.firewall.allowedUDPPorts = [ 2049 111 53317 ];
   networking.firewall.allowedTCPPortRanges = [
     { from = 32765; to = 32769; }
   ];
   networking.firewall.allowedUDPPortRanges = [
     { from = 32765; to = 32769; }
   ];
}
