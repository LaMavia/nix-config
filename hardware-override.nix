{ lib, ... }:
{
  swapDevices = lib.mkForce
    [ 
      { 
        device = "/dev/disk/by-uuid/385c3dfa-51b0-4f37-8752-0f0a14a30c3a"; 
        options = [
         "x-systemd.decive-timeout=1ms" 
        ];
      }
    ];
}
