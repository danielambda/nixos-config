{ pkgs, inputs, ... }: {

  environment.systemPackages = with pkgs; [
    mako
    libnotify

    git
    gcc
    wget
    zip
    unzip
    libz
    zlib

    home-manager
  ];

  services.udev.packages = [pkgs.vial];
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "632ea29085f0ad42"
    ];
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
  ];
}
