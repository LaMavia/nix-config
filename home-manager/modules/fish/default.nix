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
      end
    '';

    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
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
    ];
  };

  home.packages = with pkgs; [
    starship
    grc
    fish
    # (mommy.override {
    #   mommySettings = {};
    # })
  ];

  home.file.".config/starship.toml".source = ./starship.toml;
}
