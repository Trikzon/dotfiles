{ config, pkgs, ... }: {
  imports = [ ./git.nix ];

  home.packages = with pkgs; [
    tree
    unstable.claude-code
  ];

  home.file."Storage".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage";

  # Home Manager's equivalent of system.stateVersion. Never change it.
  home.stateVersion = "26.05";
}
