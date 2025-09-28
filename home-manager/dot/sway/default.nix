{ pkgs, ... }:
{
  imports = [
    ../swaync/default.nix
    ../swaylock/default.nix
    ../waybar/default.nix
    ../kitty/default.nix
    ../rofi/default.nix
  ];

  home.packages = with pkgs; [
    sway-contrib.inactive-windows-transparency
    # python311Packages.i3ipc
  ];

  home.file.".config/sway/wallpaper.png" = {
    source = ../../resources/simple-bulb.png;
  };

  home.file.".config/sway/config".source = ./config;

}
