{
  services.dbus.enable = true;

  services.openssh.enable = true;

  services.blueman.enable = true;

  services.flatpak.enable = true;

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
    desktopManager = {
      gnome.enable = true;
      runXdgAutostartIfNone = true;
    };
    displayManager = {
      gdm.enable = true;
    };
    
  };
}
