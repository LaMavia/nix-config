{ config, pkgs, user, ... }:

{
  imports = [
    ./dot/rofi.nix
    ./dot/kitty.nix
    ./dot/sway.nix
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
    scala
    jetbrains.idea-community
    starship
    lazygit
    rustc
    cargo
  ];

  home.sessionVariables = {};

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
