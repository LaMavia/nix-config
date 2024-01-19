{ ... }:
{
  home.file.".config/sway/wallpaper.png" = {
    source = ../../resources/nix-dracula.png;
  };
  home.file.".config/sway/config".source = ./config;

}
