{ pkgs, lib, ... }:

{
  imports = [
    # dot files
    ./dot/sway/default.nix
    ./dot/foot/default.nix
    ./dot/tmux/default.nix
    ./dot/gestures/default.nix
    # program configs
    ./modules/git.nix
    ./modules/fish/default.nix
    ./modules/gtk.nix
    ./modules/fonts.nix
    ./modules/direnv.nix
    ./modules/nvim/default.nix
    ./modules/lvim/default.nix
    # ./modules/nixvim/default.nix
  ];
  
  home.enableNixpkgsReleaseCheck = false;
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
    file-roller
    nodejs_22
    zoom-us
    signal-desktop
    vscode
    spotify
    tokei
    unzip
    htop
    slack
    onlyoffice-bin_latest
    (lib.hiPrio zed-editor)
    zed
    whatsapp-for-linux
    discord
    # blender-hip
    (callPackage ./modules/mc/pkg.nix {})
    # (callPackage ./modules/zen/pkg.nix {})
  ];

  home.shellAliases = {
    zed-editor = lib.getExe pkgs.zed-editor;
  };

  home.sessionVariables = { };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _:true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
