{ self, inputs, ... }: {
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.mainConfiguration

      self.nixosModules.users
      self.nixosModules.desktop

      self.nixosModules.niri
      self.nixosModules.amnezia

      inputs.happ-nix.nixosModules.default
      {
        programs.happ = {
          enable = true;
          tunMode.enable = true;
        };
      }
    ];
  };
}
