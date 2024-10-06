{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    languagePacks = ["en-US" "ru"];
    nativeMessagingHosts = [pkgs.firefoxpwa];
  };

  home.packages = [pkgs.firefoxpwa];
}
