{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
    config = ./niri.config.kdl; 
  };

  home.packages = with pkgs; [
    swww
  ];
}
