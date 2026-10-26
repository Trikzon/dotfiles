# Networking, firewall, and remote access.
{ ... }: {
  # Manage connections with nmcli / nmtui.
  networking.networkmanager.enable = true;

  # On by default; kept explicit. Services can open their own ports when needed.
  networking.firewall.enable = true;
}
