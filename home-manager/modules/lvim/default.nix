{ pkgs, ... }:
{
  home.file.".config/lvim/config.lua".source = ./config.lua;

  home.packages = with pkgs; [
    lunarvim
    lazygit
    ripgrep
    bottom
    nixd
    prettierd
  ];
}
