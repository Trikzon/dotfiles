# Nix itself: flakes, nixpkgs settings, and store maintenance.
{ inputs, lib, ... }: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs = {
    # Unfree packages allowed by name, instead of allowing all of them.
    config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "claude-code" ];

    overlays = [
      # pkgs.unstable.<name> gives packages from nixos-unstable; everything
      # else stays on 26.05. Shares this nixpkgs config (unfree list included).
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (final.stdenv.hostPlatform) system;
          config = prev.config;
        };
      })
    ];
  };

  # Weekly: delete generations older than 14 days, then unreferenced store paths.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Hardlink identical files in the store on a schedule.
  nix.optimise.automatic = true;
}
