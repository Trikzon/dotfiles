# Nix itself: flakes and store maintenance.
{ ... }: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Weekly: delete generations older than 14 days, then unreferenced store paths.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Hardlink identical files in the store on a schedule.
  nix.optimise.automatic = true;
}
