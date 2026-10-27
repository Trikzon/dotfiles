{ pkgs, ... }: {
  users.users.dion = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  home-manager.users.dion = ../home/dion;
}
