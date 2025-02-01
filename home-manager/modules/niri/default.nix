{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swww
    xwayland-satellite
    fuzzel
  ];

  home.file."~/.scripts" = {
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
