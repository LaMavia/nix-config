{ pkgs, ... }:
{
  systemd = {  
    services."getty@tty1".enable = false;
    services."autovt@tty1".enable = false;
    extraConfig = ''
      DefaultTimeoutStopSec=1s
    '';


    user.services.kanshi = {
      description = "kanshi daemon";
      serviceConfig = {
        Type = "simple";
        ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
      };
    };
  };
}
