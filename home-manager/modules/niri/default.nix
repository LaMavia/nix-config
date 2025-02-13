{ pkgs, ... }:
{
  imports = [
    ../../dot/fuzzel/default.nix
    ../../dot/waybar/default.nix
    ../../dot/swaync/default.nix
  ];
  home.packages = with pkgs; [
    swww
    xwayland-satellite
    fuzzel
  ];

  home.file.".scripts" = {
    source = ./scripts;
    recursive = true;
  };

  home.file.".config/niri/wallpaper.png" = {
    source = ../../resources/simple-bulb.png;
  };

  programs.niri = {
    config = builtins.readFile ./niri.config.kdl;
  };

}
