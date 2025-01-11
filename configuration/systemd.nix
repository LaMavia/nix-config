{ pkgs, ... }:
{
  systemd = {  
    services."getty@tty1".enable = false;
    services."autovt@tty1".enable = false;
    services.gamma = {
      enable = true;
      serviceConfig = { 
        RestartSec = 5; 
        ExecStart = "${pkgs.gammastep}/bin/gammastep -l 52.237049:21.017532 -t +6500:+3500";
      };
    };
    extraConfig = ''
      DefaultTimeoutStopSec=1s
    '';

    user.services = {
      kanshi = {
        description = "kanshi daemon";
        serviceConfig = {
          Type = "simple";
          ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
        };
      };
    };
  };
}
