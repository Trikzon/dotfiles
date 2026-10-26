{ pkgs, ... }: {
  users.users.dion = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    # TODO: move to Home Manager.
    packages = with pkgs; [
      tree
    ];
  };
}
