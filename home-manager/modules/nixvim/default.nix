{ pkgs, lib, inputs, ... }:
{
  programs.nixvim = {
    enable = true;
    imports = [ 
      inputs.Neve.nixvimModule 
    ];
    colorschemes.catppuccin.enable = lib.mkForce false;
    colorschemes.nord.enable = true;
  };
}
