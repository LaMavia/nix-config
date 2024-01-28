{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sway-contrib.inactive-windows-transparency
    python311Packages.i3ipc
  ];

  home.file.".config/sway/wallpaper.png" = {
    source = ../../resources/simple-paisage.png;
  };

  home.file.".config/sway/config".source = ./config;

}
