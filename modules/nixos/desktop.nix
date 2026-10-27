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

  # Noctalia's bluetooth and power-profile features talk to these. upower is
  # left out: it only serves battery status, and this machine has no battery.
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;

  environment.systemPackages = with pkgs; [
    # TODO: move to Home Manager.
    alacritty
    # niri spawns this on demand to run X11 apps.
    xwayland-satellite
  ];
}
