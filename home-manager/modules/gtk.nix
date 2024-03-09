{ pkgs, ... }:
let 
  cursor-theme = "Catppuccin-Mocha-Dark-Cursors";
  cursor-theme-package = pkgs.catppuccin-cursors.mochaDark;
in
{
  dconf = {
    enable = true;
  };

  home.pointerCursor = {
    gtk.enable = true;   
      name = cursor-theme;
      package = cursor-theme-package;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = cursor-theme;
      package = cursor-theme-package;
    };
    theme = {
      name = "Catppuccin-Macchiato-Standard-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "standard";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
    };
  };
}
