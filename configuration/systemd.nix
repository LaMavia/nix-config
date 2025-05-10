{ pkgs, ... }:
{
  systemd = {
    services."getty@tty1".enable = false;
    services."autovt@tty1".enable = false;

    extraConfig = ''
      DefaultTimeoutStopSec=1s
    '';

    user.services = {
      gamma = {
        enable = true;
        description = "gammastep for redshift:3";
        unitConfig = {
          After = [ "graphical-session.target" ];
        };
        serviceConfig = {
          Type = "simple";
          PassEnvironment = "DISPLAY";
          ExecStart = "${pkgs.gammastep}/bin/gammastep -l 52.237049:21.017532 -t +6500:+3500";
          RestartSec = 10;
          Restart = "on-failure";
        };
        wantedBy = [ "default.target" ];
      };

      # swww = {
      #   enable = true;
      #   description = "swww daemon";
      #   after = [ "graphical-session.target" ];
      #   wantedBy = [ "default.target" ];
      #   serviceConfig = {
      #     ExecStart = "${pkgs.swww}/bin/swww-daemon";
      #     RestartSec = 10;
      #     Restart = "on-failure";
      #   };
      # };

      kanshi = {
        description = "kanshi daemon";
        serviceConfig = {
          Type = "simple";
          ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
        };
      };

      mpris-proxy = {
        description = "Mpris proxy";
        after = [ "network.target" "sound.target" ];
        wantedBy = [ "default.target" ];
        serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
      };
    };
  };
}
