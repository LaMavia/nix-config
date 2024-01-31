{ config, pkgs, user, ... }:

{
  imports = [
    # dot files
    ./dot/rofi/default.nix
    ./dot/kitty/default.nix
    ./dot/sway/default.nix
    ./dot/swaylock/default.nix
    ./dot/waybar/default.nix
    ./dot/foot/default.nix
    ./dot/tmux/default.nix
    # program configs
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/gtk.nix
    ./modules/nvim/default.nix
  ];
  home.username = "mavia";
  home.homeDirectory = "/home/mavia";

  home.packages = with pkgs; [
    brave
    thunderbird
    bun
    rustc
    cargo
    octaveFull
    amberol
    eartag
    gnome.file-roller
    nodejs_21
    zoom-us
    signal-desktop
  ];

  home.sessionVariables = { };

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
