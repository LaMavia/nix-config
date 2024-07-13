{ ... }:
{
  virtualisation.docker = {
    enable = true;
    setSocketVariable = true;
  };
  users.users.mavia.extraGroups = [ "docker" ];
}
