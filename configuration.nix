# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

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
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  # kvm
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  # libvirt 
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull ];
        };
      };
    };
  };

  programs.virt-manager.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_6_6;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "ca_ES.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

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

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
  };

  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  hardware.pulseaudio.enable = false;

  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
    };
  };

  services.displayManager = {
    enable = true;
    autoLogin = {
      enable = true;
      user = "mavia";
    };
  };


  services.xserver = {
    enable = true;
    xkb = {
      variant = "";
      layout = "pl";
    };
    desktopManager.gnome.enable = true;
    displayManager = {
      gdm.enable = true;
    };
  };

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=1s
  '';

  services.dbus.enable = true;

  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.nix-ld.enable = true;

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.fish = {
    enable = true;
  };

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # setup fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
      ];
    })
  ];

  users.users.mavia = {
    isNormalUser = true;
    description = "Zuzanna Surowiec";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "qemu-libvirtd" ];
    shell = pkgs.bash;
  };

  services.openssh.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
