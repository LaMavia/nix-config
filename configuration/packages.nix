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

  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        export gnome_schema=org.gnome.desktop.interface
        export GTK_THEME=nordic
        echo "$XDG_DATA_DIRS | $gnome_schema"
        gsettings set $gnome_schema gtk-theme 'Dracula'
        gsettings set org.gnome.desktop.wm.preferences theme 'Nordic'
        # gsettings set $gnome_schema icon-theme 'Adwaita'
        gsettings set $gnome_schema cursor-theme 'Volantes Cursors'
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
    configure-gtk
    kitty
    wayland
    xdg-utils
    glib
    nordic
    gnome3.adwaita-icon-theme
    volantes-cursors
    grim
    slurp
    wl-clipboard
    wdisplays
    tmux
    waybar
    gnome.nautilus
    rofi-wayland
    swaynotificationcenter
    brightnessctl
    pulseaudio
    home-manager
    # c
    gcc
    clang
    clang-tools
    # gdb
    gdb
    gef
    # virt
    libvirt
    virt-manager
    win-virtio
    OVMFFull
    swtpm
  ];
}
