{ self, inputs, ... }: {
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.mainConfiguration

      self.nixosModules.users
      self.nixosModules.desktop

      self.nixosModules.niri
      self.nixosModules.amnezia
    ];
  };
}
