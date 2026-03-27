{ inputs, self, ... }: {
  flake.configs.noctalia.settings =
    builtins.fromJSON (builtins.readFile ./noctalia.json)
    // {
      colors = builtins.fromJSON (builtins.readFile ./colors.json);
    };

  perSystem = { pkgs, ... }: {
    packages.noctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = self.configs.noctalia.settings;
    };
  };
}
