{ config, pkgs, ... }:

{
  home.username = "mavia";
  home.homeDirectory = "/home/mavia";

  home.packages = [];
  home.sessionVariables = {};

  programs.zsh = {
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } 
      ];
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Volantes Cursors";
      package = pkgs.volantes-cursors;
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
