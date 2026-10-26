# Elgato Game Capture HD60 S: the driver comes from the hd60s flake input.
{ inputs, ... }: {
  imports = [ inputs.hd60s.nixosModules.default ];

  # The kernel loads hd60s on its own when the card is plugged in (udev alias
  # from the USB IDs), so it isn't listed in boot.kernelModules.
  # The AMD xHCI controller can't deliver SuperSpeed isochronous data, so
  # video never arrives unless the driver uses bulk transfers.
  boot.extraModprobeConfig = "options hd60s force_bulk=1";
}
