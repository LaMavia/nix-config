{ pkgs, ... }:
{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Volantes Cursors";
      package = pkgs.volantes-cursors;
    };
  };
}
