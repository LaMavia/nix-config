{ pkgs, lib, ... }:
{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          kimpanel.extensionUuid
          user-themes.extensionUuid
          zen.extensionUuid
        ];
      };
      "org/gnome/desktop/input-sources" = {
        show-all-sources = true;
        sources = [
          (lib.gvariant.mkTuple [ "xkb" "pl" ])
          (lib.gvariant.mkTuple [ "xkb" "jp" ])
        ];
        xkb-options = [ "terminate:ctrl_alt_bksp" ];
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-macchiato-pink-standard+rimless";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "standard";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
    };
  };
}
