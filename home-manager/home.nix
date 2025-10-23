{ pkgs, lib, inputs, ... }:

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
    ./modules/niri/default.nix
  ];

  home.enableNixpkgsReleaseCheck = false;
  home.username = "mavia";
  home.homeDirectory = "/home/mavia";

  home.packages = with pkgs; [
    thunderbird
    bun
    rustc
    cargo
    amberol
    file-roller
    nodejs_22
    zoom-us
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
    bat
    hyfetch
    (callPackage ./modules/mc/pkg.nix { })
    eza
    uutils-coreutils-noprefix
    dust
    signal-desktop
    # inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.shellAliases = {
    zed-editor = lib.getExe pkgs.zed-editor;
    li = "${lib.getExe pkgs.eza} -l --icons";
  };

  home.sessionVariables = { };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _:true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
