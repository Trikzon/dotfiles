# Networking, firewall, and remote access.
{ ... }: {
  # Manage connections with nmcli / nmtui.
  networking.networkmanager.enable = true;

  # On by default; kept explicit. Modules open their own ports (openssh opens 22).
  networking.firewall.enable = true;

  services.openssh.enable = true;
}
