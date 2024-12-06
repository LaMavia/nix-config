{
  services.dbus.enable = true;

  services.openssh.enable = true;

  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
    };
  };

  services.displayManager = {
    enable = true;
    autoLogin = {
      enable = true;
      user = "mavia";
    };
  };


  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager = {
      runXdgAutostartIfNone = true;
      setupCommands = ''
          export XKB_DEFAULT_MODEL=jp106
          export XKB_DEFAULT_LAYOUT=jp,ca
          export XKB_DEFAULT_OPTIONS=grp:rctrl_toggle
          export GTK_IM_MODULE=fcitx
          export QT_IM_MODULE=fcitx
          export XMODIFIERS=@im=fcitx
          fcitx5 -r
      '';
      gdm.enable = true;
    };
    
  };
}
