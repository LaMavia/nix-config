{ pkgs, ... }:
{
  home.packages = with pkgs; [
    onagre
    libqalculate
  ];
}
