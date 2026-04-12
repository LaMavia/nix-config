{ pkgs, config, ... }:
let
  path = "/home/mavia/.nixos/home-manager/modules/nvim/config_";
in
{
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${path}";
  };

  home.packages = with pkgs;[
    neovim
    lazygit
    ripgrep
    bottom
    nixd
    prettierd
    gcc
  ];
}
