{ config, pkgs, user, ... }:

{
  imports = [
    ./dot/rofi.nix
    ./dot/kitty.nix
    ./dot/sway.nix
    ./modules/git.nix
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

  programs.zsh = {
    enable = true;
    initExtra=''
      eval "$(starship init zsh)"
    '';
    enableAutosuggestions = true;
    autocd = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } 
      ];
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Volantes Cursors";
      package = pkgs.volantes-cursors;
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
