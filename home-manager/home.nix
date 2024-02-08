{ config, pkgs, user, ... }:

{
  imports = [
    # dot files
    ./dot/sway/default.nix
    ./dot/foot/default.nix
    ./dot/tmux/default.nix
    # program configs
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/gtk.nix
    ./modules/fonts.nix
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
    waylock
    volantes-cursors
  ];

  home.file.".icons/default/index.theme".text = ''
    [icon theme] 
    Inherits=Volantes Cursors
  '';

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.volantes-cursors;
    name = "Volantes Cursors";
    size = 13;
  };

  home.sessionVariables = { };

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
