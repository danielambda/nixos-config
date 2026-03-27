{ inputs, self, lib, ... }: let
  colors = self.configs.noctalia.settings.colors;
  mkWhichKey = pkgs: menu:
    (self.wrapperModules.which-key.apply {
      inherit pkgs;
      settings = {
        inherit menu;

        font = "JetBrainsMono Nerd Font 12";
        border = colors.mSurface;
        background = colors.mPrimary;
        color = colors.mOnPrimary;
        separator = " ➜ ";
        border_width = 2;
        corner_r = 0;
        padding = 8;
        rows_per_column = 2;
        column_padding = 16;

        anchor = "bottom-right";
        margin_right = 8;
        margin_bottom = 8;
        margin_left = 0;
        margin_top = 0;
      };
    }).wrapper;
in {
  flake.mkWhichKeyExe = pkgs: menu: lib.getExe (mkWhichKey pkgs menu);

  flake.wrapperModules.which-key = inputs.wrappers.lib.wrapModule (
    { config, ... }:
    let
      yamlFormat = config.pkgs.formats.yaml {};
      configFile = yamlFormat.generate "config.yaml" config.settings;
    in {
      options.settings = lib.mkOption {
        type = yamlFormat.type;
      };

      config = {
        package = config.pkgs.wlr-which-key;
        args = [(toString configFile)];
      };
    }
  );
}
