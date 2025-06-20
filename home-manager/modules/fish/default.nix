{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      starship init fish | source
      direnv hook fish | source
      if test "$TERM" = "xterm-kitty";
        alias kssh="TERM=xterm-256color ssh"
        set -U __done_kitty_remote_control 1
        set -U __done_kitty_remote_control_password "kitty-rc-password"
      end
    '';

    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      {
        name = "loadenv";
        src = pkgs.fetchFromGitHub {
          owner = "berk-karaal";
          repo = "loadenv.fish";
          rev = "e5ad1b3e8cf779bd897a5fa4c0dc55a920b01ed7";
          sha256 = "RyGjJ8NxTqEr9MW7hnrTlry6fW+IF4el1IPUh7WIwxU=";
        };
      }
      # Manually packaging and enable a plugin
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
    ];
  };

  home.packages = with pkgs; [
    starship
    grc
    fish
    jq
  ];

  home.file.".config/starship.toml".source = ./starship.toml;
}
