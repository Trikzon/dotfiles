{ pkgs, ... }: {
  users.users.dion = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.dion = ../home/dion;
}
