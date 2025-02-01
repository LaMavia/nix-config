{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swww
  ];

  home.file."~/.scripts" = {
    source = ./scripts;
    recursive = true;
  };

  programs.niri = {
    config = builtins.readFile ./niri.config.kdl;
  };

}
