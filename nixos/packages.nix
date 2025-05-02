{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    mako
    libnotify

    git
    gcc
    zip
    unzip

    home-manager
  ];

  services.udev.packages = [pkgs.vial];
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
  ]
  ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
