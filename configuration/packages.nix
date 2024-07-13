{ pkgs, ... }:
let
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    git
    kanshi
    fish
    gnutar
    zip
    wget
    brave
    sway
    dbus-sway-environment
    kitty
    wayland
    xdg-utils
    glib
    nordic
    adwaita-icon-theme
    volantes-cursors
    grim
    slurp
    wl-clipboard
    wdisplays
    tmux
    waybar
    nautilus
    rofi-wayland
    swaynotificationcenter
    brightnessctl
    pulseaudio
    home-manager
  ];
}
