{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "standard";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
    };
  };
}
