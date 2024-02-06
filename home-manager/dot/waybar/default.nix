{ pkgs, ... }:
{
  home.packages = with pkgs; [
    font-awesome
  ];
  home.file.".config/waybar/config".source = ./themes/own/config.json5;
  home.file.".config/waybar/style.css".source = ./themes/own/style.css;
}
