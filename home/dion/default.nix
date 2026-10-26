{ config, pkgs, ... }: {
  imports = [
    ./git.nix
    ./librewolf.nix
  ];

  home.packages = with pkgs; [
    tree
    unstable.claude-code
    # Discord refuses to start when outdated, so take it from unstable.
    unstable.discord
  ];

  # Nix can't apply Discord's self-updates, so stop it from asking for them.
  xdg.configFile."discord/settings.json".text = builtins.toJSON {
    SKIP_HOST_UPDATE = true;
  };

  services.mako.enable = true;

  home.file."Storage".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage";

  # Home Manager's equivalent of system.stateVersion. Never change it.
  home.stateVersion = "26.05";
}
