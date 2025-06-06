{ inputs, system, ...}: {
  imports = [inputs.zen-browser.homeModules.twilight];

   xdg.mimeApps = let
    associations = builtins.listToAttrs (map (name: {
        inherit name;
        value = inputs.zen-browser.packages.${system}.twilight.meta.desktopFile;
      }) [
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-html"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "text/plain"
        "text/html"
        "image/*"
      ]);
  in {
    associations.added = associations;
    defaultApplications = associations;
  };

  programs.zen-browser = {
    enable = true;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = true;
    };
  };
}
