{ ... }:
{
  fileSystems."/".options = [ 
   "data=journal" 
   "x-systemd.device-timeout=1ms" 
   "nofail"
  ];
}
