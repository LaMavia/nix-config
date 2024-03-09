{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libinput-gestures
  ];

  home.file.".config/libinput-gestures.conf".text = ''
  gesture swipe up	${./next-workspace.fish} next
  '';
}
