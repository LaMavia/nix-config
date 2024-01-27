{ config, pkgs, user, ... }:

{
  imports = [
    # dot files
    ./dot/rofi/default.nix
    ./dot/kitty/default.nix
    ./dot/sway/default.nix
    ./dot/waybar/default.nix
    ./dot/foot/default.nix
    ./dot/tmux/default.nix
    # program configs
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/gtk.nix
  ];
  home.username = "mavia";
  home.homeDirectory = "/home/mavia";

  home.packages = with pkgs; [
    git
    rofi
    zsh
    zplug
    brave
    thunderbird
    neovim
    glab
    gh
    bun
    starship
    lazygit
    rustc
    cargo
    octaveFull
    amberol
    eartag
    planner
    gnome.file-roller
    nodejs_21
    ripgrep
    bottom
    neovim
  ];

  home.sessionVariables = {};

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
