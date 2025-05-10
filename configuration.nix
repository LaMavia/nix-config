# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  boot.loader = {
    timeout = 10;

    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    # efi = {
    #   efiSysMountPoint = "/boot/EFI";
    #   canTouchEfiVariables = true;
    # };
    #
    # grub = {
    #   enable = true;
    #   efiSupport = true;
    #   device = "nodev";
    #   configurationLimit = 50;
    # };
  };

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n = let l = "es_ES.UTF-8"; in
    {
      defaultLocale = l;
      extraLocaleSettings = {
        LC_ADDRESS = l;
        LC_IDENTIFICATION = l;
        LC_MEASUREMENT = l;
        LC_MONETARY = l;
        LC_NAME = l;
        LC_NUMERIC = l;
        LC_PAPER = l;
        LC_TELEPHONE = l;
        LC_TIME = l;
      };

      inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          waylandFrontend = true;
          addons = with pkgs; [
            fcitx5-gtk
            fcitx5-mozc
            fcitx5-chinese-addons
            rime-data
            fcitx5-rime
            fcitx5-nord
          ];
        };
      };
    };

  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    # XDG_CURRENT_DESKTOP = "sway";
    LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
    GLFW_IM_MODULE = "fcitx";
    # GTK_IM_MODULE = "fcitx";
    INPUT_METHOD = "fcitx";
    XMODIFIERS = "@im=fcitx";
    IMSETTINGS_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    SDL_IM_MODULE = "fcitx";
  };


  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = with pkgs; [
      # xdg-desktop-portal-gtk 
      xdg-desktop-portal-wlr
    ];
  };

  # setup fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    openmoji-color
    nerd-fonts.droid-sans-mono
    fira-code
    fira-code-symbols
    font-awesome
    nerd-fonts.symbols-only
  ];

  users.users.mavia = {
    isNormalUser = true;
    description = "Zuzanna Surowiec";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "qemu-libvirtd" ];
    shell = pkgs.bash;
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
