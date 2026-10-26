# Graphical session: niri on Wayland, audio, printing, and desktop apps.
{ pkgs, ... }: {
  # Also pulls in gnome-keyring, gcr-ssh-agent (the SSH agent), and
  # pinentry-gnome3 via services.graphical-desktop.
  programs.niri.enable = true;
  hardware.graphics.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    # TODO: move to Home Manager.
    alacritty
    fuzzel
    # niri spawns this on demand to run X11 apps.
    xwayland-satellite
  ];
}
