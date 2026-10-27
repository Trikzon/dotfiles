{ pkgs, ... }: {
  users.users.dion = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.dion = ../home/dion;
}
