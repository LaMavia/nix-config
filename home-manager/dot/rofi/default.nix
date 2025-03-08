{ pkgs, ... }:
{
  home.file.".config/rofi/shared/colors.rasi".source = ./colors.rasi;
  home.file.".config/rofi/shared/fonts.rasi".source = ./fonts.rasi;
  home.file.".config/rofi/config.rasi".source = ./themes/spotlight-dark.rasi;

  home.packages = with pkgs; [
    rofi-wayland
  ];
}
