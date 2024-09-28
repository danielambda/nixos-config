{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./modules
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "24.05"; # Did you read the comment?
}
