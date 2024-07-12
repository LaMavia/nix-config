{
  services.dbus.enable = true;

  services.openssh.enable = true;

  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  hardware.pulseaudio.enable = false;

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
    xkb = {
      variant = "";
      layout = "pl";
    };
    desktopManager.gnome.enable = true;
    displayManager = {
      gdm.enable = true;
    };
  };
}
