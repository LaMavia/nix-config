{ pkgs, ... }:
{
  home.packages = with pkgs; [
    font-awesome
  ];
  home.file.".config/waybar/config".source = ./config.json5;
  home.file.".config/waybar/style.css".source = ./style.css;
}
