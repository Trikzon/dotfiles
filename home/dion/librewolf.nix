# LibreWolf browser. Add preferences under `policies.Preferences` as you decide on them.
{ lib, ... }:
let
  # Everything the address bar can suggest. Switched off one by one because
  # there is no single pref for it.
  urlbarSuggestions = [
    "addons"
    "amp"
    "bookmark"
    "calculator"
    "clipboard"
    "engines"
    "history"
    "importantDates"
    "mdn"
    "openpage"
    "quickactions"
    "realtimeOptIn"
    "recentsearches"
    "remotetab"
    "searches"
    "sports"
    "topsites"
    "trending"
    "weather"
    "wikipedia"
    "yelp"
    "yelpRealtime"
  ];

  # Status "default" sets the default only, so the UI can still change it.
  defaultPref = Value: {
    inherit Value;
    Status = "default";
  };
in
{
  programs.librewolf = {
    enable = true;

    policies = {
      # Set through policy rather than `settings`: Home Manager writes
      # `settings` to ~/.librewolf, which this LibreWolf doesn't read (it uses
      # ~/.config/librewolf). Policies are baked into the package instead.
      Preferences = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = defaultPref true;

        # 1 is compact, 0 is normal.
        "browser.uidensity" = defaultPref 1;

        # LibreWolf turns these off. The CDMs are separate downloads, see
        # media.gmp-manager.updateEnabled in LibreWolf's mozilla.cfg.
        "media.gmp-widevinecdm.enabled" = defaultPref true;
        "media.gmp-gmpopenh264.enabled" = defaultPref true;
      }
      // lib.genAttrs (map (name: "browser.urlbar.suggest.${name}") urlbarSuggestions) (
        _: defaultPref false
      );

      # Plain DoH with fallback to the system resolver; the provider stays
      # LibreWolf's default (Quad9).
      DNSOverHTTPS = {
        Enabled = true;
        Locked = false;
      };

      # LibreWolf also asks per site before playing DRM content.
      EncryptedMediaExtensions = {
        Enabled = true;
        Locked = false;
      };

      # LibreWolf clears cookies on exit by default, which signs you out of
      # sites. The Preferences policy can't set the clearOnShutdown prefs.
      SanitizeOnShutdown = {
        Cookies = false;
        Locked = false;
      };

      # nixpkgs has no Bitwarden browser extension package, so install it from
      # addons.mozilla.org via policy. normal_installed lets the user disable it.
      ExtensionSettings."{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
        installation_mode = "normal_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        default_area = "navbar";
      };
    };
  };

  # Home Manager hardcodes ~/.librewolf for this file, which LibreWolf doesn't
  # read here; it is empty, so don't create the directory.
  home.file.".librewolf/native-messaging-hosts".enable = false;
}
