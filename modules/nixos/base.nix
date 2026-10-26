# Settings every machine gets: locale and core command-line tools.
{ pkgs, ... }: {
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Tools worth having even as root or on a broken system.
  environment.systemPackages = with pkgs; [
    curl
    git
    vim
    wget

    # TODO: move to per-project dev shells.
    nodejs_22
  ];

  programs.gnupg.agent.enable = true;
}
