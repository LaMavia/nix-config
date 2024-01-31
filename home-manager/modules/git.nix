{ pkgs, ... }:
{
  programs.git = {
    enable = false;
    userName = "LaMavia";
    userEmail = "ts438730@students.mimuw.edu.pl";
  };

  home.packages = with pkgs; [
    git
    glab
    gh
  ];
}
