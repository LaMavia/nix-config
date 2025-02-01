{ pkgs, ... }:
{
  home.files = {
    ".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini; 
  };
}
