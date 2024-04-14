{ pkgs, ... }:

{
  imports = [
    # dot files
    ./dot/sway/default.nix
    ./dot/foot/default.nix
    ./dot/tmux/default.nix
    ./dot/gestures/default.nix
    # program configs
    ./modules/git.nix
    ./modules/fish.nix
    ./modules/gtk.nix
    ./modules/fonts.nix
    ./modules/direnv.nix
    # ./modules/nvim/default.nix
    ./modules/lvim/default.nix
    # ./modules/nixvim/default.nix
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
    vscode
    spotify
    haskellPackages.haskell-language-server
  ];

  home.sessionVariables = { };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _:true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
