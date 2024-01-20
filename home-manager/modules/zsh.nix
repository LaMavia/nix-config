{...}:
{
  programs.zsh = {
    enable = true;
    initExtra=''
      eval "$(starship init zsh)"
    '';
    enableAutosuggestions = true;
    autocd = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } 
        { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };
  };
}
