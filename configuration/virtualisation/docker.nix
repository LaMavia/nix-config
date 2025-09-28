{ ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  users.users.mavia.extraGroups = [ "docker" ];
}
