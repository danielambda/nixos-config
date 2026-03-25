{ self, ... }: {
  flake.nixosModules.mainConfiguration = {
    imports = [
      self.nixosModules.mainHardware
      self.nixosModules.niri
    ];

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    boot.loader = {
      systemd-boot.configurationLimit = 5;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];
    system.stateVersion = "24.05"; # Did you read the comment?
  };
}
