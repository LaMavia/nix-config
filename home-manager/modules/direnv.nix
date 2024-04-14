{ pkgs, ... }:
{
  home.packages = with pkgs; [
    direnv
  ];

  programs = {
    direnv = {
      enable = true;
      # enableFishIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };
}
