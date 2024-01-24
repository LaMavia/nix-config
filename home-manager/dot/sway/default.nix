{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sway-contrib.inactive-windows-transparency
    python311Packages.i3ipc
  ];

  home.file.".config/sway/wallpaper.png" = {
    source = ../../resources/jerry-zhang-hkhCV41gOpA-unsplash.jpg;
  };

  home.file.".config/sway/config".source = ./config;

}
