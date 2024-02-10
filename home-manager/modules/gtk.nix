{ pkgs, ... }:
{
  dconf = {
    enable = true;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name="Volantes Cursors";
      package = pkgs.volantes-cursors;
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
