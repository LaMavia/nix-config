{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swayidle
    swaylock
  ];

  home.file.".config/swaylock/config".source = ./config;
}
