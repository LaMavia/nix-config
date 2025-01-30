{
  services = {
    dbus.enable = true;

    openssh.enable = true;

    blueman.enable = true;

    flatpak.enable = true;

    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = true;
      };
    };

    displayManager = {
      enable = true;
      autoLogin = {
        enable = true;
        user = "mavia";
      };
    };


    xserver = {
      enable = true;
      desktopManager = {
        gnome.enable = true;
        runXdgAutostartIfNone = true;
      };
      displayManager = {
        gdm.enable = true;
      };
      
    };
  };
}
