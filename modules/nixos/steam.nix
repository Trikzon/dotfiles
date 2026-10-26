# Steam, with the 32-bit graphics stack and udev rules it needs.
{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    # Fixes some games (video codecs, launch problems) that stock Proton doesn't.
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
}
