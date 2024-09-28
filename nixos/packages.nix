{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    waybar
    mako
    libnotify

    git
    gcc
    wget
    zip
    unzip

    home-manager
  ];
}
