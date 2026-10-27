{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./git.nix
    ./librewolf.nix
  ];

  home.packages = with pkgs; [
    mpv
    tree
    unstable.claude-code
    # Discord refuses to start when outdated, so take it from unstable.
    unstable.discord
    # Launcher, bar, and notifications (replaces fuzzel and mako). 26.05 only
    # has 5.0.1, so take it from unstable.
    unstable.noctalia
  ];

  # Nix can't apply Discord's self-updates, so stop it from asking for them.
  xdg.configFile."discord/settings.json".text = builtins.toJSON {
    SKIP_HOST_UPDATE = true;
  };

  # Without these, xdg-open picks whichever installed app lists the type first.
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      lib.genAttrs [
        "video/mp4"
        "video/webm"
        "video/x-matroska"
        "audio/flac"
        "audio/mpeg"
        "audio/ogg"
      ] (_: "mpv.desktop")
      // lib.genAttrs [
        "text/html"
        "application/xhtml+xml"
        "application/pdf"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ] (_: "librewolf.desktop")
      // {
        # Claude Code registered this itself; Home Manager now owns the file.
        "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
      };
  };

  home.file."Storage".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage";

  # Home Manager's equivalent of system.stateVersion. Never change it.
  home.stateVersion = "26.05";
}
