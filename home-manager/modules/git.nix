{ pkgs, ... }:
{
  programs.git = {
    enable = false;
    settings = {
      user = {
        name = "LaMavia";
        email = "zs438730@students.mimuw.edu.pl";
      };
    };
  };

  home.packages = with pkgs; [
    git
    glab
    gh
  ];
}
